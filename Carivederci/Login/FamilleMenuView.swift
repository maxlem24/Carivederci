//
//  FamilleMenuView.swift
//  Carivederci
//
//  Created by Maxime on 14/02/2024.
//

import SwiftUI

struct FamilleMenuView: View {
    @Binding var skipFamille : Bool
    @EnvironmentObject var appUser : AppUser
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
                        Text("Bonjour \(appUser.user!.pseudo)").font(.title).bold().foregroundColor(.white).padding(5)
                        NavigationLink(destination :
                                        FamilleView( newFamily : true)
                                       ,label: {
                                        Text("Créer une Famille").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Taupe"))) .cornerRadius(10)
                                       }
                        )
                        NavigationLink(destination :
                                        FamilleView(newFamily : false)
                                       ,label: {
                                        Text("Rejoindre une famille").font(.title2).bold().foregroundColor(.white).padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Taupe"))) .cornerRadius(10)
                                       }
                        )
                        Text("Accéder à l'application").font(.title2).foregroundColor(.white).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Taupe"))) .cornerRadius(10).onTapGesture {
                            skipFamille = true
                        }
                        Spacer()
                    }
                }
            }
        }.accentColor(Color("RoseBlanc"))
    }
}

