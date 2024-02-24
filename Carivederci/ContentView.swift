//
//  ContentView.swift
//  Carivederci
//
//  Created by Maxime on 29/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State var isLogged : Bool = false
    @State var hasFamily : Bool = false
    @State var pseudo : String = ""
    var body: some View {
        if isLogged {
            if hasFamily {
                MainView()
            }else {
                FamilleMenuView(hasFamily : $hasFamily, pseudo: $pseudo)
            }
        } else {
            LoginMenuView(isLogged : $isLogged, pseudo : $pseudo)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
