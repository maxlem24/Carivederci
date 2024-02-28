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
                Color("BackgroundColor").ignoresSafeArea()
                VStack {
                    switch choice {
                    case 0:
                        Text("Compte").font(.title).frame(width: geometry.size.width, height: geometry.size.height*0.1).padding(.top,50).background(Rectangle().fill(Color("Header")).cornerRadius(10))
                    case 1:
                        Text("Carivederci c'est :").font(.title).frame(width: geometry.size.width, height: geometry.size.height*0.1).padding(.top,50).background(Rectangle().fill(Color("Header")).cornerRadius(10))
                    case 3:
                        Text("Chat").font(.title).frame(width: geometry.size.width, height: geometry.size.height*0.1).padding(.top,50).background(Rectangle().fill(Color("Header")).cornerRadius(10))
                    case 4:
                        Text("Classement des familles").font(.title).frame(width: geometry.size.width, height: geometry.size.height*0.1).padding(.top,50).background(Rectangle().fill(Color("Header")).cornerRadius(10))
                    default:
                        Text("Calendrier").font(.title).frame(width: geometry.size.width, height: geometry.size.height*0.1).padding(.top,50).background(Rectangle().fill(Color("Header")).cornerRadius(10))
                    }
                    TabView(selection : $choice){
                        CompteView().foregroundColor(Color.red).tabItem { Image(systemName: "person") }.tag(0)
                        CarouselView().tabItem { Image(systemName: "info.circle") }.tag(1)
                        PlanningView().tabItem { Image(systemName: "calendar") }.tag(2)
                        ChatView().tabItem { Image(systemName: "ellipses.bubble") }.tag(3)
                        ScoreboardView().background(Color.clear).tabItem { Image(systemName: "star") }.tag(4)
                    }.animation(.easeInOut).transition(.slide)//Methode IOS 16 toolbarBackground
                }.ignoresSafeArea()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
