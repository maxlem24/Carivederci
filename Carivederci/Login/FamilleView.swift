//
//  FamilleView.swift
//  Carivederci
//
//  Created by Maxime on 17/02/2024.
//

import SwiftUI

struct FamilleView: View {
    
    @Binding var hasFamily : Bool
    @State var pseudo : String = ""
    @State var password : String = ""
    let newFamily : Bool
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color("Bordeaux").ignoresSafeArea()
                VStack(alignment : .leading){
                    HStack{
                        Spacer()
                        Image("PP2").resizable().scaledToFill().clipShape(Circle()).frame(width: geometry.size.height*0.4, height: geometry.size.height*0.4).padding(.vertical,20)
                        Spacer()
                    }
                    Text("Nom de la famille").bold().foregroundColor(.white).padding(5)
                    TextField(
                        "Nom de la famille",
                        text : $pseudo
                    ).foregroundColor(.white).accentColor(.white)
                    .autocapitalization(.none).disableAutocorrection(true)
                    .frame(width: geometry.size.width*0.9).padding(5).background(Rectangle().fill(Color.gray).cornerRadius(10))
                    
                    Text("Mot de passe").bold().foregroundColor(.white).padding(5)
                    SecureField(
                        "Mot de passe",
                        text : $password
                    ).foregroundColor(.white).accentColor(.white)
                    .autocapitalization(.none).disableAutocorrection(true)
                    .frame(width: geometry.size.width*0.9).padding(5).background(Rectangle().fill(Color.gray).cornerRadius(10))
                    HStack{
                        Spacer()
                        Button{
                            hasFamily = connexionFamille(pseudo: pseudo, password: password)
                        } label :{
                            Image(systemName: "arrow.right").resizable().foregroundColor(.white).padding(5)
                        }.scaledToFill().frame(width: geometry.size.width*0.1,height : geometry.size.width*0.1).padding(5)
                        .background(Circle().fill(Color.gray))
                        Spacer()
                    }
                    Spacer()
                    
                }.padding()
            }
        }
        
    }
}

func connexionFamille(pseudo:String, password:String) -> Bool {
    if pseudo == "" || password == ""  {
        return false
    }
    return true
}
