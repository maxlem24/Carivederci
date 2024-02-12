//
//  SignupView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct SigninView: View {
    @Binding var isLogged : Bool
    @State var pseudo : String = ""
    @State var password : String = ""
    var body: some View {
        VStack{
            HStack{
                Text("Pseudo")
                TextField(
                    "Pseudo",
                    text : $pseudo
                )
                .padding().autocapitalization(.none)
                .disableAutocorrection(true)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }.padding().background(Color("Button"))
            HStack{
                Text("Mot de passe")
                TextField(
                    "Mot de passe",
                    text : $password
                )
                .padding().autocapitalization(.none)
                .disableAutocorrection(true)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }.padding().background(Color("Button"))
            Button("Créer un compte"){
                isLogged = connexion(pseudo: pseudo, password: password)
            }.padding().background(Color("Button"))
        }.background(Color("BackgroundColor"))
    }
}

func connexion(pseudo:String, password:String) -> Bool {
    if pseudo == "" || password == ""  {
        return false
    }
    return true
}


