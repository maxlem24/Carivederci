//
//  CompteView.swift
//  Carivederci
//
//  Created by Maxime on 28/02/2024.
//

import SwiftUI

struct CompteView: View {
    var body: some View {
        GeometryReader {
            geometry in
            VStack(spacing:0){
                NavigationView {
                    ZStack(alignment :.topLeading) {
                        Color("BackgroundColor").ignoresSafeArea()
                        VStack(alignment:.leading){
                            HStack{
                                Spacer()
                                Image("PP1").resizable().scaledToFill().clipShape(Circle()).frame(width: geometry.size.height*0.15, height: geometry.size.height*0.15).padding(.vertical,20)
                                Spacer()
                            }
                            NavigationLink(destination: Text("Destination")) { Label("Changer de mot de passe", systemImage: "lock.shield.fill").font(.title3)
                            
                            }.background(Color.clear)
                            Spacer()
                        }.padding()
                    }
                }
            }
            
        }
    }
}

struct CompteView_Previews: PreviewProvider {
    static var previews: some View {
        CompteView()
    }
}
