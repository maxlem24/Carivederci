//
//  ContentView.swift
//  Carivederci
//
//  Created by Maxime on 29/12/2023.
//

import SwiftUI

let hostName : String = "http://delmoo.fr:5001/molky"

struct ContentView: View {
    @State var skipFamille : Bool = false
    @StateObject var appUser = AppUser()
    var body: some View {
        if appUser.user != nil {
            if appUser.user?.famille != nil  || skipFamille{
                MainView().environmentObject(appUser)
            }else {
                FamilleMenuView(skipFamille : $skipFamille)
                    .environmentObject(appUser)
            }
        } else {
            LoginMenuView().environmentObject(appUser)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
