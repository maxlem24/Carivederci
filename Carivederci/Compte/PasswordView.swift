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
                        Color("BackgroundColor").ignoresSafeArea()
                        VStack(alignment:.leading){
                            Text("Vous serez déconnecté après avoir changé vottre mot de passe.").foregroundColor(Color("AccentColor"))
                                .font(.body)
                                .padding(.vertical,10)
                            Text("Votre mot de passe doit contenir au moins 8 caractères et doit être une combinaison de chiffres, lettres et caractères spéciaux.").foregroundColor(Color("AccentColor"))
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
                                    .fill(Color("CalendarBackground"))
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
                                    .fill(Color("CalendarBackground"))
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
                                    .fill(Color("CalendarBackground"))
                                    .cornerRadius(10))
                            .padding(.vertical,10)
                            Spacer()
                            Button{
                            }label :{
                                Text("Changer le mot de passe").foregroundColor(Color("Header")).padding()
                            }.frame(width: geometry.size.width*0.9).padding(5)
                            .background(Rectangle().fill(Color("Bordeaux")).cornerRadius(10))
                        
                        }.padding()
                    }
                }
            }
        }
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
    }
}
