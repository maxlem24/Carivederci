//
//  ContentView.swift
//  Carivederci
//
//  Created by Maxime on 29/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State var hasFamily : Bool = false
    @State var pseudo : String = ""
    @StateObject var appUser = AppUser()
    var body: some View {
        if appUser.user != nil {
            if hasFamily {
                MainView().environmentObject(appUser)
            }else {
                FamilleMenuView(hasFamily : $hasFamily, pseudo: $pseudo).environmentObject(appUser)
            }
        } else {
            LoginMenuView(pseudo : $pseudo).environmentObject(appUser)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
