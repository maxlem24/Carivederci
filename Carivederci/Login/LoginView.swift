//
//  LoginView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLogged : Bool
    @State var pseudo : String = ""
    @State var password : String = ""
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment : .center,spacing : 20){
                HStack{
                    Text("Pseudo").bold().padding()
                    TextField(
                        "Pseudo",
                        text : $pseudo
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).padding()
                }.padding(.horizontal).frame(width: geometry.size.width*0.9, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Button")).cornerRadius(10))
                HStack{
                    Text("Mot de passe").bold().padding()
                    TextField(
                        "Mot de passe",
                        text : $password
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).padding()
                }.padding(.horizontal).frame(width: geometry.size.width*0.9, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Button")).cornerRadius(10))
                Button("Se connecter"){
                    isLogged = connexion(pseudo: pseudo, password: password)
                }.padding().frame(width: geometry.size.width*0.9, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Button")).cornerRadius(10))
               
            }.background(Color("BackgroundColor")).frame(width: geometry.size.width, height: geometry.size.height)
        }
        
    }
    
}


