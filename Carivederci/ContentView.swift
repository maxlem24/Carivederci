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
    var body: some View {
        if AppUser.shared.getUser() != nil {
            if AppUser.shared.getFamille() != nil  || skipFamille{
                MainView()
            }else {
                FamilleMenuView(skipFamille : $skipFamille)
            }
        } else {
            LoginMenuView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
