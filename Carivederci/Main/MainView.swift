//
//  MainView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct MainView: View {
    @State private var choice = 2
    var body: some View {
        GeometryReader {
            geometry in
            ZStack{
                Color("BlancRosé").ignoresSafeArea()
                    TabView(selection : $choice){
                        CompteView().foregroundColor(Color.red)
                            .tabItem { Image(systemName: "person") }.tag(0)
                        CarouselView()
                            .tabItem { Image(systemName: "info.circle") }.tag(1)
                        PlanningView()
                            .tabItem { Image(systemName: "calendar") }.tag(2)
                        SponsorsView()
                            .tabItem { Image(systemName: "checkmark.seal") }.tag(3)
                        ScoreboardView()
                            .tabItem { Image(systemName: "star") }.tag(4)
                    }.accentColor(Color("Bordeaux")).foregroundColor(Color("Marron")).transition(.slide)//Methode IOS 16 toolbarBackground
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
