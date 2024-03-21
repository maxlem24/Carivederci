//
//  LoginMenuView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct LoginMenuView: View {
    var body: some View {
        ZStack{
            NavigationStack{ // NavigationStack IOS 16 + toolBarBackground
                GeometryReader{
                    geometry in
                    Color("Bordeaux").ignoresSafeArea()
                    
                    VStack {
                        HStack{
                            Spacer()
                            Image("PP2").resizable().scaledToFill().clipShape(Circle()).frame(width: geometry.size.height*0.4, height: geometry.size.height*0.4).padding(.vertical,20)
                            Spacer()
                        }
                        NavigationLink(destination :
                                        LoginView(newUser : true)
                                       ,label: {
                                        Text("Inscription").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(RoundedRectangle(cornerRadius: 10).fill(Color("Button")))
                                       })
                        NavigationLink(destination :
                                        LoginView(newUser : false)
                                       ,label: {
                                        Text("Connexion").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(RoundedRectangle(cornerRadius: 10).fill(Color("Button")))
                                       })
                        Spacer()
                    }
                }
            }
        }
    }
}
