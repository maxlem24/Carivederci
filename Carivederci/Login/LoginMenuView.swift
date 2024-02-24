//
//  LoginMenuView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct LoginMenuView: View {
    @Binding var isLogged : Bool
    @Binding var pseudo : String
    var body: some View {
        ZStack{
            
            NavigationView{ // NavigationStack IOS 16 + toolBarBackground
                GeometryReader{
                    geometry in
                    Color("Bordeaux").ignoresSafeArea()
                    
                    VStack {
                        HStack{
                            Spacer()
                            Image("PP2").resizable().scaledToFill().clipShape(Circle()).frame(width: geometry.size.height*0.4, height: geometry.size.height*0.4).padding(.vertical,20)
                            Spacer()
                        }
                        NavigationLink(destination :
                                        LoginView(isLogged:$isLogged,pseudo: $pseudo, newUser : true)
                                       ,label: {
                                        Text("Inscription").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Button"))) .cornerRadius(10)
                                       }
                        )
                        NavigationLink(destination :
                                        LoginView(isLogged:$isLogged,pseudo: $pseudo, newUser : false)
                                       ,label: {
                                        Text("Connexion").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Button"))) .cornerRadius(10)
                                       }
                        )
                        Spacer()
                    }
                }
            }
        }
    }
}

struct LMView_Previews: PreviewProvider {
    static var previews: some View {
        LoginMenuView(isLogged: .constant(false),pseudo: .constant(""))
    }
}
