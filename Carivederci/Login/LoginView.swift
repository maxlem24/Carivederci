//
//  LoginView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLogged : Bool
    @Binding var pseudo : String
    @State var nom : String = ""
    @State var prenom : String = ""
    @State var mail : String = ""
    @State var password : String = ""
    let newUser : Bool
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color("Bordeaux").ignoresSafeArea()
                VStack(alignment : .leading){
                    HStack{
                        Spacer()
                        Image("PP2").resizable().scaledToFill().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).frame(width: geometry.size.height*0.4, height: geometry.size.height*0.4).padding(.vertical,20)
                        Spacer()
                    }
                    ScrollView{
                    if(newUser){
                        Group {
                            Text("Nom").bold().foregroundColor(.white).padding(5)
                            TextField(
                                "Nom",
                                text : $nom
                            ).foregroundColor(.white).accentColor(.white)
                            .autocapitalization(.none).disableAutocorrection(true)
                            .frame(width: geometry.size.width*0.9).padding(5).background(Rectangle().fill(Color.gray).cornerRadius(10))
                        }
                        Group {
                            Text("Prenom").bold().foregroundColor(.white).padding(5)
                            TextField(
                                "Prenom",
                                text : $prenom
                            ).foregroundColor(.white).accentColor(.white)
                            .autocapitalization(.none).disableAutocorrection(true)
                            .frame(width: geometry.size.width*0.9).padding(5).background(Rectangle().fill(Color.gray).cornerRadius(10))
                        }
                    }
                    Group {
                        Text("Pseudo").bold().foregroundColor(.white).padding(5)
                        TextField(
                            "Pseudo",
                            text : $pseudo
                        ).foregroundColor(.white).accentColor(.white)
                        .autocapitalization(.none).disableAutocorrection(true)
                        .frame(width: geometry.size.width*0.9).padding(5).background(Rectangle().fill(Color.gray).cornerRadius(10))
                    }
                    if(newUser){
                        Group {
                            Text("Adresse Email").bold().foregroundColor(.white).padding(5)
                            TextField(
                                "Adresse Email",
                                text : $mail
                            ).foregroundColor(.white).accentColor(.white)
                            .autocapitalization(.none).disableAutocorrection(true)
                            .frame(width: geometry.size.width*0.9).padding(5).background(Rectangle().fill(Color.gray).cornerRadius(10))
                        }
                        
                    }
                    Group {
                        Text("Mot de passe").bold().foregroundColor(.white).padding(5)
                        SecureField(
                            "Mot de passe",
                            text : $password
                        ).foregroundColor(.white).accentColor(.white)
                        .autocapitalization(.none).disableAutocorrection(true)
                        .frame(width: geometry.size.width*0.9).padding(5).background(Rectangle().fill(Color.gray).cornerRadius(10))
                    }
                    }
                    HStack{
                        Spacer()
                        Button{
                            isLogged = connexion(pseudo: pseudo, password: password)
                        }label :{
                            Image(systemName: "arrow.right").resizable().foregroundColor(.white).padding(5)
                        }.scaledToFill().frame(width: geometry.size.width*0.1,height : geometry.size.width*0.1).padding(5)
                        .background(Circle().fill(Color.gray).cornerRadius(10))
                        Spacer()
                    } 
                    Spacer()
                }.padding(.horizontal)
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


