//
//  LogoView.swift
//  Carivederci
//
//  Created by Maxime on 25/02/2024.
//

import SwiftUI

struct YoutubeView: View {
    var body: some View {
        GeometryReader{
            geometry in
            ZStack {
                Color("BlancRosé").ignoresSafeArea()
                VStack{
                    Image("Logo").resizable().scaledToFit().frame(height: geometry.size.height*0.4)
                    Link("Notre chaine youtube", destination: URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ&themeRefresh=1")!).font(.title).accentColor(Color("Marron")).padding()
                    Image("Youtube").resizable().scaledToFit().frame(height: geometry.size.height*0.2)
                    
                }
            }
        }
    }
}

struct YoutubeView_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeView()
    }
}
