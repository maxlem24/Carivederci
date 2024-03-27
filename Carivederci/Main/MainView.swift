//
//  MainView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct MainView: View {
    @State private var choice = 2
    @State var header = ""
    var body: some View {
        GeometryReader {
            geometry in
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                VStack {
                    Text(header).font(.title).frame(width: geometry.size.width, height: geometry.size.height*0.1).padding(.top,50).background(Rectangle().fill(Color("Header")).cornerRadius(10))
                    TabView(selection : $choice){
                        CompteView(header : $header).foregroundColor(Color.red)
                            .tabItem { Image(systemName: "person") }.tag(0)
                        CarouselView(header : $header)
                            .tabItem { Image(systemName: "info.circle") }.tag(1)
                        PlanningView()
                            .tabItem { Image(systemName: "calendar") }.tag(2)
                            .onAppear(perform: {
                                header = "Calendrier"
                            })
                        SponsorsView()
                            .tabItem { Image(systemName: "checkmark.seal") }.tag(3)
                            .onAppear(perform: {
                                header = "Nos sponsors"
                            })
                        ScoreboardView()
                            .tabItem { Image(systemName: "star") }.tag(4)
                            .onAppear(perform: {
                                header = "Le classement des familles"
                            })
                    }.animation(.easeInOut).transition(.slide)//Methode IOS 16 toolbarBackground
                }.ignoresSafeArea()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(AppUser(user : User(id: "1234-ABCD", pseudo: "Test",score: 1024, profil: "PP2",isAdmin: true)))
    }
}
