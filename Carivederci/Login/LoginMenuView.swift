//
//  LoginMenuView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct LoginMenuView: View {
    @Binding var isLogged : Bool
    var body: some View {
        NavigationView{ // NavigationStack IOS 16 + toolBarBackground
            GeometryReader{
                geometry in
                ZStack{
                    Color("Bordeaux").ignoresSafeArea()
                    VStack {
                        
                        Image("PP2").resizable().scaledToFill().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).frame(width: geometry.size.width*0.7, height: geometry.size.width*0.7)
                        Spacer()
                        NavigationLink(destination :
                                        LoginView(isLogged:$isLogged, newUser : false)
                                       ,label: {
                                        Text("Se connecter").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Button"))) .cornerRadius(10)
                                       })
                        NavigationLink(destination :
                                        LoginView(isLogged:$isLogged, newUser : true)
                                       ,label: {
                                        Text("Créer un compte").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Button"))) .cornerRadius(10)
                                       })
                        Spacer()
                    }
                }
            }
            
        }
    }
}

struct LMView_Previews: PreviewProvider {
    static var previews: some View {
        LoginMenuView(isLogged: .constant(false))
    }
}
