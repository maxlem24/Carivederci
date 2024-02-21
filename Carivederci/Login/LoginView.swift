//
//  LoginView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLogged : Bool
    @State var pseudo : String
    @State var password : String
    let newUser : Bool
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color("Bordeaux").ignoresSafeArea()
                VStack(alignment : .leading,spacing : 20){
                    Text("Pseudo").bold().padding(5).accentColor(.white)
                    TextField(
                        "Pseudo",
                        text : $pseudo
                    ).tag(/*@START_MENU_TOKEN@*/"Tag"/*@END_MENU_TOKEN@*/).foregroundColor(.white).accentColor(.white)
                    .autocapitalization(.none).disableAutocorrection(true)
                    .frame(width: geometry.size.width*0.9).padding(5).background(Rectangle().fill(Color.gray).cornerRadius(10))
                    
                    Text("Mot de passe").bold().padding(5).accentColor(.white)
                    SecureField(
                        "Mot de passe",
                        text : $password
                    ).foregroundColor(.white).accentColor(.white)
                    .autocapitalization(.none).disableAutocorrection(true)
                    .frame(width: geometry.size.width*0.9).padding(5).background(Rectangle().fill(Color.gray).cornerRadius(10))
                    HStack{
                        Spacer()
                        Button(newUser ? "Créer un compte" : "Se connecter"){
                            isLogged = connexion(pseudo: pseudo, password: password)
                        }.scaledToFit().frame(width: geometry.size.width*0.5).padding(5)
                        .background(Rectangle().fill(Color.gray).cornerRadius(10))
                        Spacer()
                    }
                    
                }.padding()
            }
        }
        
    }
}

func connexion(pseudo:String, password:String) -> Bool {
    if pseudo == "" || password == ""  {
        return false
    }
    return true
}


