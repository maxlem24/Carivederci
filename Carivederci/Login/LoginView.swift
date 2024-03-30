//
//  LoginView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appUser : AppUser
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
                    if (!showMessage){
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
                        }
                        HStack{
                            Spacer()
                            Button{
                                pseudoError = isValidPseudo(pseudo) ? "" : "Pseudo invalide : il doit contenir au moins 6 caractères et pas de caractère spéciaux"
                                if newUser {
                                    nomError = isValidNom(nom) ? "" : "Nom invalide : il doit contenir uniquement des lettres et au moins 2 lettres"
                                    prenomError = isValidPrenom(prenom) ? "" : "Prenom invalide : il doit contenir uniquement des lettres et au moins 2 lettres"
                                    mailError = isValidMail(mail) ? "" : "Adresse Mail invalide : le format ne correspond pas"
                                }
                                passwordError = isValidPassword(password) ? "" : "Mot de passe invalide : il doit contenir au moins 8 caractères, avec une majuscule, une minuscule, un chiffre et un caractère spécial"
                                if pseudoError == "" && nomError == "" && prenomError == "" && mailError == "" && passwordError == "" {
                                    if newUser {
                                        showMessage = true
                                    }else {
                                        appUser.user = User(id: "1234-ABCD", pseudo: pseudo,score: 1024, profil: "PP2")
                                    }
                                }
                            }label :{
                                Image(systemName: "arrow.right").resizable().foregroundColor(Color("RoseBlanc")).padding(5)
                            }.scaledToFill().frame(width: geometry.size.width*0.1,height : geometry.size.width*0.1).padding(5)
                            .background(Circle().fill(Color("Taupe")))
                            Spacer()
                        }
                    }
                    Spacer()
                }.padding(.horizontal)
                if (showMessage) {
                    alertMessage( mail : mail,pseudo : pseudo, geometry : geometry).padding(.horizontal,5).navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

struct alertMessage : View{
    @EnvironmentObject var appUser : AppUser
    let mail : String
    let pseudo : String
    let geometry : GeometryProxy
    var body: some View {
        VStack {
            Text("Un message a été envoyé a l'adresse mail suivante : \(mail)").foregroundColor(.white).padding(5)
            Button{
                appUser.user = User(id: "1234-ABCD", pseudo: pseudo,score: 1024, profil: "PP2")
            }label :{
                Text("Ok").bold().foregroundColor(Color("RoseBlanc")).padding(5)
            }.scaledToFill()
        }.padding().background(Rectangle().fill(Color("Taupe")).cornerRadius(10)).frame(width: geometry.size.width*0.9)
    }
}

struct FieldView : View {
    let nom : String
    @Binding var field : String
    @Binding var errorField : String
    let width : CGFloat
    var isSecure = false
    var body : some View {
        Text(nom).bold().foregroundColor(.white).padding(5)
        if isSecure {
            SecureField(
                nom,
                text : $field
            ).foregroundColor(.white).accentColor(.white)
            .autocapitalization(.none).disableAutocorrection(true)
            .frame(width: width).padding(5).background(Rectangle().fill(Color("Taupe")).cornerRadius(10))
        }else {
            TextField(
                nom,
                text : $field
            ).foregroundColor(.white).accentColor(.white)
            .autocapitalization(.none).disableAutocorrection(true)
            .frame(width: width).padding(5).background(Rectangle().fill(Color("Taupe")).cornerRadius(10))
        }
        Text(errorField).font(.footnote).foregroundColor(.red).padding(5)
    }
}

