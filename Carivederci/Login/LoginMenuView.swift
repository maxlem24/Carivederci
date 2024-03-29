//
//  LoginMenuView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct LoginMenuView: View {
    var body: some View {
        NavigationView{ // NavigationStack IOS 16 + toolBarBackground
            GeometryReader{
                geometry in
                ZStack{
                    Color("Bordeaux").ignoresSafeArea()
                    
                    VStack {
                        HStack{
                            Spacer()
                            Image("Logo").resizable().scaledToFit().frame(width: geometry.size.height*0.4, height: geometry.size.height*0.4).padding(.vertical,20)
                            Spacer()
                        }
                        NavigationLink(destination :
                                        LoginView(newUser : true)
                                       ,label: {
                                        Text("Inscription").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(RoundedRectangle(cornerRadius: 10).fill(Color("Taupe")))
                                       })
                        NavigationLink(destination :
                                        LoginView(newUser : false)
                                       ,label: {
                                        Text("Connexion").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(RoundedRectangle(cornerRadius: 10).fill(Color("Taupe")))
                                       })
                        Spacer()
                    }
                }
            }
        }.accentColor(Color("RosePale"))
    }
}

