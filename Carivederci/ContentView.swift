//
//  ContentView.swift
//  Carivederci
//
//  Created by Maxime on 29/12/2023.
//

import SwiftUI

let hostName : String = "https://carivederci.site:5000/molky"

struct ContentView: View {
    @State var skipFamille : Bool = false
    @ObservedObject var appUser : AppUser = AppUser.shared
    var body: some View {
        if appUser.user != nil {
            if appUser.famille != nil  || skipFamille{
                MainView()
            }else {
                FamilleMenuView(skipFamille : $skipFamille)
            }
        } else {
            LoginMenuView().onAppear(){
                skipFamille = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
