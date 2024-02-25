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
    @State var showMessage = false
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
                    if (!showMessage){
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
                            if connexion(pseudo: pseudo, password: password) {
                                if newUser {
                                    showMessage = true
                                }else {
                                    isLogged = true
                                }
                            }
                        }label :{
                            Image(systemName: "arrow.right").resizable().foregroundColor(.white).padding(5)
                        }.scaledToFill().frame(width: geometry.size.width*0.1,height : geometry.size.width*0.1).padding(5)
                        .background(Circle().fill(Color.gray))
                        Spacer()
                    }
                    }
                    Spacer()
                }.padding(.horizontal)
                if (showMessage) {
                    alertMessage(isLogged : $isLogged, mail : mail, geometry : geometry).padding(.horizontal,5).navigationBarBackButtonHidden(true)
                }
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


struct alertMessage : View{
    @Binding var isLogged : Bool
    let mail : String
    let geometry : GeometryProxy
    var body: some View {
        VStack {
            Text("Un message a été envoyé a l'adresse mail suivante : \(mail)").foregroundColor(.white).padding(5)
            Button{
                isLogged = true
            }label :{
                Text("Ok").bold().foregroundColor(.white).padding(5)
            }.scaledToFill()
        }.padding().background(Rectangle().fill(Color.gray).cornerRadius(10)).frame(width: geometry.size.width*0.9)
    }
}

