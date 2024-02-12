//
//  LoginMenuView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//
enum Choice {
    case menu
    case login
    case signin
}

import SwiftUI

struct LoginMenuView: View {
    @Binding var isLogged : Bool
    @State var choice : Choice = Choice.menu
    var body: some View {
        switch choice {
        case .menu:
            VStack(alignment: .center){
                Button("Se connecter"){
                    choice = Choice.login
                }
                Button("Nouvel Utilisateur"){
                    choice = Choice.signin
                }
            }
        case .login:
            LoginView(isLogged : $isLogged)
        case .signin :
            SigninView(isLogged : $isLogged)
        }
        
    }
}
