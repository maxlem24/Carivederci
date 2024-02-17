//
//  FamilleMenuView.swift
//  Carivederci
//
//  Created by Maxime on 14/02/2024.
//

import SwiftUI

struct FamilleMenuView: View {
    @Binding var hasFamily : Bool
    var body: some View {
        NavigationView{ // NavigationStack IOS 16 + toolBarBackground
            GeometryReader{
                geometry in
                ZStack{
                    Color("Bordeaux").ignoresSafeArea()
                    VStack {
                        Spacer()
                        Image("PP2").resizable().scaledToFill().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).frame(width: geometry.size.width*0.7, height: geometry.size.width*0.7)
                        Spacer()
                        NavigationLink(destination :
                                        FamilleView(hasFamily : $hasFamily,newFamily : false)
                                       ,label: {
                                        Text("Rejoindre une famille").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Button"))) .cornerRadius(10)
                                       })
                        NavigationLink(destination :
                                        FamilleView(hasFamily : $hasFamily, newFamily : true)
                                       ,label: {
                                        Text("Créer une Famille").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Button"))) .cornerRadius(10)
                                       })
                        Text("Continuer sans famille").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Button"))) .cornerRadius(10).onTapGesture {
                            hasFamily = true
                        }
                        Spacer()
                    }
                }
            }
            
        }
    }
}

