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
            ZStack{
                Color("Bordeaux")
                VStack {
                    NavigationLink(destination :
                                    LoginView(isLogged:$isLogged, newUser : false)
                                   ,label: {
                                    Text("Se connecter").foregroundColor(.white).bold().padding()
                                        .background(Color("Bouton")).cornerRadius(10)
                                   })
                    NavigationLink(destination :
                                    LoginView(isLogged:$isLogged, newUser : true)
                                   ,label: {
                                    Text("Créer un compte").bold().padding().background(Color("Bouton")).cornerRadius(10)
                                   })
                }
            }.ignoresSafeArea()
        }
    }
}
