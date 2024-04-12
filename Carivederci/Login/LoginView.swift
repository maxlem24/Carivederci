//
//  LoginView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @State var pseudo : String = ""
    @State var pseudoError : String = ""
    @State var nom : String = ""
    @State var nomError : String = ""
    @State var prenom : String = ""
    @State var prenomError : String = ""
    @State var mail : String = ""
    @State var mailError : String = ""
    @State var password : String = ""
    @State var passwordError : String = ""
    @State var passwordCopy : String = ""
    @State var passwordCopyError : String = ""
    @State var errorText : String = ""
    let newUser : Bool
    @State var showMessage = false
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color("Bordeaux").ignoresSafeArea()
                VStack(alignment : .leading){
                    HStack{
                        Spacer()
                        Image("Logo").resizable().scaledToFit().frame(width: geometry.size.height*0.4, height: geometry.size.height*0.4).padding(.vertical,20)
                        Spacer()
                    }
                    ScrollView{
                        let width = geometry.size.width*0.9
                        if(newUser){
                            FieldView(nom:"Nom",field:$nom,errorField : $nomError, width : width)
                            FieldView(nom:"Prenom",field:$prenom,errorField : $prenomError, width : width)
                        }
                        FieldView(nom:"Pseudo",field:$pseudo, errorField : $pseudoError, width : width)
                        if(newUser){
                            FieldView(nom:"Adresse Email",field:$mail, errorField : $mailError, width : width)
                        }
                        FieldView(nom: "Mot de passe", field: $password, errorField: $passwordError, width: width, isSecure: true)
                        if(newUser){
                            FieldView(nom:"Retapez le mot de passe",field:$passwordCopy, errorField : $passwordCopyError, width : width, isSecure : true)
                        }
                    }
                    Text(errorText).font(.callout).foregroundColor(.red).padding(5)
                    HStack{
                        Spacer()
                        Button{
                            checkFields()
                        }label :{
                            Image(systemName: "arrow.right").resizable().foregroundColor(Color("RoseBlanc")).padding(5)
                        }.scaledToFill().frame(width: geometry.size.width*0.1,height : geometry.size.width*0.1).padding(5)
                            .background(Circle().fill(Color("Taupe")))
                        Spacer()
                    }
                    Spacer()
                }.padding(.horizontal)
                if (showMessage) {
                    VStack {
                        Text("Un message a été envoyé a l'adresse mail suivante : \(mail)").foregroundColor(Color("RoseBlanc")).padding(5)
                        Button{
                            self.presentationMode.wrappedValue.dismiss()
                        }label :{
                            Text("Ok").bold().foregroundColor(Color("RoseBlanc")).padding(5)
                        }.scaledToFill()
                    }.padding().background(Rectangle().fill(Color("Taupe")).cornerRadius(10)).frame(width: geometry.size.width*0.9).padding(.horizontal,5).navigationBarBackButtonHidden(true)
                }
            }
        }
    }
    func checkFields() {
        pseudoError = isValidPseudo(pseudo) ? "" : "Pseudo invalide : il doit contenir au moins 6 caractères et pas de caractère spéciaux"
        if newUser {
            nomError = isValidNom(nom) ? "" : "Nom invalide : il doit contenir uniquement des lettres et au moins 2 lettres"
            prenomError = isValidPrenom(prenom) ? "" : "Prenom invalide : il doit contenir uniquement des lettres et au moins 2 lettres"
            mailError = isValidMail(mail) ? "" : "Adresse Mail invalide : le format ne correspond pas"
            passwordCopyError = isValidPassword(passwordCopy) ? "" : "Mot de passe invalide : il doit contenir au moins 8 caractères, avec une majuscule, une minuscule, un chiffre et un caractère spécial"
        }
        passwordError = isValidPassword(password) ? "" : "Mot de passe invalide : il doit contenir au moins 8 caractères, avec une majuscule, une minuscule, un chiffre et un caractère spécial"
        if pseudoError == "" && nomError == "" && prenomError == "" && mailError == "" && passwordError == "" && passwordCopyError == ""{
            if password != passwordCopy && newUser{
                passwordError = "Le mot de passe saisie n'est pas identique"
                passwordCopyError = "Le mot de passe saisie n'est pas identique"            }else {
                    Task {
                        if newUser {
                            await register()
                        }
                    }
                }
        }
    }
    func register() async {
        guard let url = URL(string : hostName+"/register") else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        do{
            guard let passwordHash = hash(password: password),
                  let passwordCopyHash = hash(password: passwordCopy),
                  let encoded = try? JSONEncoder().encode(UserAPI(username: pseudo, nom: nom, prenom: prenom, email: mail, password: passwordHash, repeatPassword: passwordCopyHash))
            else {
                errorText = "Une erreur est survenue, veuillez réessayer"
                return
            }
            var request = URLRequest(url : url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data,response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode != 201 {
                if let decodedResponse = try? JSONDecoder().decode(Message.self, from: data) {
                    errorText = decodedResponse.message
                }
            } else {
                showMessage = true
            }
        } catch {
            errorText = error.localizedDescription
        }
    }
    func login() async {
        guard let url = URL(string : hostName+"/login") else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        do{
            guard let passwordHash = hash(password: password),
                  let encoded = try? JSONEncoder().encode(UserAPI(username: pseudo, nom: nil, prenom: nil, email: nil, password: passwordHash, repeatPassword: nil))
            else {
                errorText = "Une erreur est survenue, veuillez réessayer"
                return
            }
            var request = URLRequest(url : url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data,response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 201 {
                if let decodedResponse = try? JSONDecoder().decode(APIConnect.self, from: data) {
                    Auth.shared.setCredentials(accessToken: decodedResponse.token)
                    AppUser.shared.setUser(user: decodedResponse.user)
                }
            } else {
                if let decodedResponse = try? JSONDecoder().decode(Message.self, from: data) {
                    errorText = decodedResponse.message
                }
            }
        } catch {
            errorText = error.localizedDescription
        }
    }}



struct FieldView : View {
    let nom : String
    var textColor : Color = Color("RoseBlanc")
    var bgColor : Color = Color("Taupe")
    @Binding var field : String
    @Binding var errorField : String
    let width : CGFloat
    var isSecure = false
    var body : some View {
        Text(nom).bold().foregroundColor(textColor).padding(5)
        if isSecure {
            SecureField(
                nom,
                text : $field
            ).foregroundColor(textColor).accentColor(textColor)
                .autocapitalization(.none).disableAutocorrection(true)
                .frame(width: width).padding(5).background(RoundedRectangle(cornerRadius: 10).fill(bgColor))
        }else {
            TextField(
                nom,
                text : $field
            ).foregroundColor(textColor).accentColor(textColor)
                .autocapitalization(.none).disableAutocorrection(true)
                .frame(width: width).padding(5).background(RoundedRectangle(cornerRadius: 10).fill(bgColor))
        }
        Text(errorField).font(.footnote).foregroundColor(.red).padding(5)
    }
}

