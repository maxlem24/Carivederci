//
//  PasswordView.swift
//  Carivederci
//
//  Created by Maxime on 01/03/2024.
//

import SwiftUI

struct PasswordView: View {
    @State var oldPasswd = ""
    @State var oldPasswdError = ""
    @State var newPasswd = ""
    @State var newPasswdCopy = ""
    @State var newPasswdError = ""
    @State var newPasswdCopyError = ""
    @State var errorText = ""
    @State var showMessage : Bool = false
    var body: some View {
        GeometryReader {
            geometry in
            VStack(spacing:0){
                    ZStack() {
                        Color("BlancRosé").ignoresSafeArea()
                        ScrollView{
                            Text("Vous serez déconnecté après avoir changé vottre mot de passe.").fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Color("Marron"))
                                .font(.body)
                                .padding(.vertical,10)
                            Text("Votre mot de passe doit contenir au moins 8 caractères et doit être une combinaison de chiffres, lettres et caractères spéciaux.").fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Color("Marron"))
                                .font(.body)
                            FieldView(nom: "Ancien mot de passe", textColor: Color("Bordeaux"), bgColor: Color("Rose"), field: $oldPasswd, errorField: $oldPasswdError, width: geometry.size.width*0.9, isSecure: true)
                            FieldView(nom: "Nouveau mot de passe", textColor: Color("Bordeaux"), bgColor: Color("Rose"), field: $newPasswd, errorField: $newPasswdError, width: geometry.size.width*0.9, isSecure: true)
                            FieldView(nom: "Retapez le mot de passe", textColor: Color("Bordeaux"), bgColor: Color("Rose"), field: $newPasswdCopy, errorField: $newPasswdCopyError, width: geometry.size.width*0.9, isSecure: true)
                            Spacer()
                            Button{
                                checkFields()
                            }label :{
                                Text("Changer le mot de passe").foregroundColor(Color("RoseBlanc")).padding()
                            }.frame(width: geometry.size.width*0.9).padding(5)
                            .background(Rectangle().fill(Color("Bordeaux")).cornerRadius(10))
                            
                        }.padding().allowsHitTesting(!showMessage)
                        if (showMessage) {
                            VStack {
                                Text("Voulez vous vraiment changer votre mot de passe ?")
                                    .foregroundColor(Color("Marron")).padding(5)
                                Text("Vous allez être déconnecté")
                                    .foregroundColor(Color("Marron")).padding(5)
                                Text(errorText).font(.callout).foregroundColor(.red).padding(5)
                                HStack{
                                    Button{
                                        Task{
                                            await resetPassword()
                                        }
                                    }label :{
                                        Text("Oui").bold().foregroundColor(Color("Marron")).padding(5)
                                    }.scaledToFill()
                                    Button{
                                        showMessage = false
                                    }label :{
                                        Text("Non").bold().foregroundColor(Color("Marron")).padding(5)
                                    }.scaledToFill()
                                }
                            }.padding().background(Rectangle().fill(Color("Rose")).cornerRadius(10)).frame(width: geometry.size.width*0.9).navigationBarBackButtonHidden(showMessage)
                        }
                }
            }
        }
    }
    func checkFields()  {
        oldPasswdError = isValidPassword(oldPasswd)  ? "" : "Mot de passe invalide : il doit contenir au moins 8 caractères, avec une majuscule, une minuscule, un chiffre et un caractère spécial"
        newPasswdError = isValidPassword(newPasswd) ? "" : "Mot de passe invalide : il doit contenir au moins 8 caractères, avec une majuscule, une minuscule, un chiffre et un caractère spécial"
        newPasswdCopyError = isValidPassword(newPasswdCopy) ? "" : "Mot de passe invalide : il doit contenir au moins 8 caractères, avec une majuscule, une minuscule, un chiffre et un caractère spécial"
        if oldPasswdError == "" && newPasswdError == "" && newPasswdCopyError == "" {
            if newPasswd != newPasswdCopy {
                newPasswdError = "Le nouveau mot de passe saisie n'est pas identique"
                newPasswdCopyError = "Le nouveau mot de passe saisie n'est pas identique"
            }else {
                showMessage = true
            }
        }
    }
    func resetPassword() async {
        guard let url = URL(string : hostName+"/change/password") else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        guard let token = Auth.shared.getAccessToken() else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        do{
            guard let encoded = try? JSONEncoder().encode(PasswordChange(password: oldPasswd, newPassword: newPasswd, repeatNewPassword: newPasswdCopy))
            else {
                errorText = "Une erreur est survenue, veuillez réessayer"
                return
            }
            
            print(String(decoding: encoded, as: UTF8.self))
            var request = URLRequest(url : url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            
            let (data,response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpResponse = response as? HTTPURLResponse
            print(String(decoding: data, as: UTF8.self))
            if httpResponse?.statusCode != 201 {
                if let decodedResponse = try? JSONDecoder().decode(Message.self, from: data) {
                    errorText = decodedResponse.message
                }
            } else {
                showMessage = false
                await MainActor.run{
                    AppUser.shared.setUser(user:nil)
                }
                Auth.shared.logout()
            }
        } catch {
            errorText = error.localizedDescription
        }
    }

}
