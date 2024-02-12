//
//  ContentView.swift
//  Carivederci
//
//  Created by Maxime on 29/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State var isLogged : Bool = false
    var body: some View {
        if isLogged {
            MainView()
        } else {
            LoginMenuView(isLogged : $isLogged)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
