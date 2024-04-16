//
//  ThemeView.swift
//  Carivederci
//
//  Created by Maxime on 25/02/2024.
//

import SwiftUI

struct ListeView: View {
    var body: some View {
            GeometryReader{
                geometry in
                ZStack{
                    Color("BlancRosé").ignoresSafeArea()
                    VStack {
                        Text("Cariverderci")
                            .font(.title).foregroundColor(Color("Marron")).padding()
                            .frame(width: geometry.size.width, height: geometry.size.height*0.1)
                            .background(Rectangle().fill(Color("RosePale")).cornerRadius(10))
                        Spacer()
                        HStack{
                            Spacer()
                            Image("Logo").resizable().scaledToFit().frame(width: geometry.size.height*0.4, height: geometry.size.height*0.4).padding(.vertical,20)
                            Spacer()
                        }
                        ScrollView{
                            Text("Bienvenue chez les Carivederci !\n\nLa famille mafieuse tout en gucci, qui va vous faire vivre une semaine de folie ! Au programme du fun, des soirées, des défis et des pastas.\n\nPassez la semaine avec les Carivederci, et qui sait, peut-être que vous finirez par faire partie de la famille.")
                                .font(.body).foregroundColor(Color("Marron")).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/).frame(width : geometry.size.width*0.9)
                            Spacer()
                        Text("À vos marques, prêts, partez !").italic().font(.title3).multilineTextAlignment(.center).frame(width : geometry.size.width*0.9)
                            Spacer()
                        }
                    }
                }
            }
    }
}

struct ListeView_Previews: PreviewProvider {
    static var previews: some View {
        ListeView()
    }
}
