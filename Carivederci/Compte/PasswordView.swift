//
//  PasswordView.swift
//  Carivederci
//
//  Created by Maxime on 01/03/2024.
//

import SwiftUI

struct PasswordView: View {
    @State var oldPasswd = ""
    @State var newPasswd = ""
    @State var newPasswdCopy = ""
    var body: some View {
        GeometryReader {
            geometry in
            VStack(spacing:0){
                NavigationView {
                    ZStack(alignment :.topLeading) {
                        Color("BlancRosé").ignoresSafeArea()
                        ScrollView{
                            Text("Vous serez déconnecté après avoir changé vottre mot de passe.").fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Color("Marron"))
                                .font(.body)
                                .padding(.vertical,10)
                            Text("Votre mot de passe doit contenir au moins 8 caractères et doit être une combinaison de chiffres, lettres et caractères spéciaux.").fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Color("Marron"))
                                .font(.body)
                                .padding(.vertical,10)
                            SecureField(
                                "Mot de passe actuel",
                                text : $oldPasswd
                            ).foregroundColor(Color("Bordeaux"))
                            .accentColor(Color("Bordeaux"))
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .frame(width: geometry.size.width*0.9)
                            .padding(5)
                            .background(
                                Rectangle()
                                    .fill(Color("Rose"))
                                    .cornerRadius(10))
                            .padding(.vertical,10)
                            SecureField(
                                "Nouveau mot de passe",
                                text : $newPasswd
                            ).foregroundColor(Color("Bordeaux"))
                            .accentColor(Color("Bordeaux"))
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .frame(width: geometry.size.width*0.9)
                            .padding(5)
                            .background(
                                Rectangle()
                                    .fill(Color("Rose"))
                                    .cornerRadius(10))
                            .padding(.vertical,10)
                            SecureField(
                                "Retapez le nouveau mot de passe",
                                text : $newPasswdCopy
                            ).foregroundColor(Color("Bordeaux"))
                            .accentColor(Color("Bordeaux"))
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .frame(width: geometry.size.width*0.9)
                            .padding(5)
                            .background(
                                Rectangle()
                                    .fill(Color("Rose"))
                                    .cornerRadius(10))
                            .padding(.vertical,10)
                            Spacer()
                            Button{
                            }label :{
                                Text("Changer le mot de passe").foregroundColor(Color("RoseBlanc")).padding()
                            }.frame(width: geometry.size.width*0.9).padding(5)
                            .background(Rectangle().fill(Color("Bordeaux")).cornerRadius(10))
                        
                        }.padding()
                    }
                }
            }
        }
    }
}
