//
//  FooterView.swift
//  Carivederci
//
//  Created by Maxime on 03/01/2024.
//

import SwiftUI

struct FooterView: View {
    @State private var choice = 2
    var body: some View {
        TabView(selection : $choice){
            Text("Page Compte").foregroundColor(Color.red).tabItem { Image(systemName: "person") }.tag(0)
            Text("Page Carivederci").foregroundColor(Color.green).tabItem { Image(systemName: "info.circle") }.tag(1)
            PlanningView().tabItem { Image(systemName: "calendar") }.tag(2)
            Text("Chat").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).tabItem { Image(systemName: "ellipses.bubble") }.tag(3)
            Text("Classement").foregroundColor(.yellow).tabItem { Image(systemName: "star") }.tag(4)
        }//Methode IOS 16 toolbarBackground
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
