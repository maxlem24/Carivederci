//
//  FamilleView.swift
//  Carivederci
//
//  Created by Maxime on 17/02/2024.
//

import SwiftUI

struct FamilleView: View {
    @State var abbvFamille : String = ""
    @State var abbvFamilleError : String = ""
    @State var nomFamille : String = ""
    @State var nomFamilleError : String = ""
    @State var password : String = ""
    @State var passwordError : String = ""
    @State var passwordCopy : String = ""
    @State var passwordCopyError : String = ""
    @State var errorText : String = ""
    let newFamily : Bool
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color("Bordeaux").ignoresSafeArea()
                VStack(alignment : .leading){
                    ScrollView{
                    HStack{
                        Spacer()
                        Image("Logo").resizable().scaledToFit().frame(width: geometry.size.height*0.4, height: geometry.size.height*0.4).padding(.vertical,10)
                        Spacer()
                    }
                    
                        if newFamily {
                            FieldView(nom: "Abbreviation de la famille", field: $abbvFamille, errorField: $abbvFamilleError, width: geometry.size.width*0.9)
                        }
                        FieldView(nom: "Nom de la famille", field: $nomFamille, errorField: $nomFamilleError, width: geometry.size.width*0.9)
                        FieldView(nom: "Mot de passe", field: $password, errorField: $passwordError, width: geometry.size.width*0.9, isSecure: true)
                        if newFamily {
                            FieldView(nom: "Retapez le mot de passe", field: $passwordCopy, errorField: $passwordCopyError, width: geometry.size.width*0.9, isSecure: true)
                        }
                    }
                    Text(errorText).font(.callout).foregroundColor(.red).padding(5)
                    HStack{
                        Spacer()
                        Button{
                            checkFields()
                        } label :{
                            Image(systemName: "arrow.right").resizable().foregroundColor(Color("RoseBlanc")).padding(5)
                        }.scaledToFill().frame(width: geometry.size.width*0.1,height : geometry.size.width*0.1).padding(5)
                            .background(Circle().fill(Color("Taupe")))
                        Spacer()
                    }
                    Spacer()
                    
                }.padding()
            }
        }
    }
    func checkFields() {
        if newFamily {
            abbvFamilleError = isValidAbbreviation(abbvFamille) ? "" : "L'abbréviation doit être uniquement composée de 3 lettres sans accents"
            passwordCopyError = isValidPassword(passwordCopy) ? "" : "Mot de passe invalide : il doit contenir au moins 8 caractères, avec une majuscule, une minuscule, un chiffre et un caractère spécial"        }
        nomFamilleError = isValidNomFamille(nomFamille) ? "" : "Nom de Famille invalide : il doit contenir au moins 6 caractères et pas de caractère spéciaux"
        passwordError = isValidPassword(password) ? "" : "Mot de passe invalide : il doit contenir au moins 8 caractères, avec une majuscule, une minuscule, un chiffre et un caractère spécial"
        
        if abbvFamilleError == "" && nomFamilleError == "" && passwordError == "" && passwordCopyError == ""{
            if password != passwordCopy && newFamily {
                passwordError = "Le mot de passe saisi n'est pas identique"
                passwordCopyError = "Le mot de passe saisi n'est pas identique"
            }else {
                Task{
                    if newFamily {
                        await createFamille()
                    }else {
                        await joinFamille()
                    }
                }
            }
        }
    }
    func joinFamille() async {
        guard let url = URL(string : hostName+"/join") else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        guard let token = Auth.shared.getAccessToken() else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        do{
            guard let encoded = try? JSONEncoder().encode(FamilleAPI(name: nomFamille.uppercased(), logo: nil, password: password, repeatPassword: nil))
            else {
                errorText = "Une erreur est survenue, veuillez réessayer"
                return
            }
            var request = URLRequest(url : url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let (data,response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 201 {
                if let decodedResponse = try? JSONDecoder().decode(Famille.self, from: data) {
                    await MainActor.run{
                        AppUser.shared.setFamille(famille: decodedResponse)
                    }
                }
            } else {
                if let decodedResponse = try? JSONDecoder().decode(Message.self, from: data) {
                    errorText = decodedResponse.message
                }
            }
        } catch {
            errorText = error.localizedDescription
        }
    }
    func createFamille() async {
        guard let url = URL(string : hostName+"/create") else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        guard let token = Auth.shared.getAccessToken() else {
            errorText = "Une erreur est survenue avec le token, veuillez réessayer"
            return
        }
        do{
            guard let encoded = try? JSONEncoder().encode(FamilleAPI(name: nomFamille, logo: abbvFamille, password: password, repeatPassword: passwordCopy))
            else {
                errorText = "Une erreur est survenue, veuillez réessayer"
                return
            }
            var request = URLRequest(url : url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let (data,response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 201 {
                if let decodedResponse = try? JSONDecoder().decode([Famille].self, from: data) {
                    await MainActor.run{
                        AppUser.shared.setFamille(famille: decodedResponse[0])
                    }
                }
            } else {
                if let decodedResponse = try? JSONDecoder().decode(Message.self, from: data) {
                    errorText = decodedResponse.message
                }
            }
        } catch {
            errorText = error.localizedDescription
        }
    }
}
