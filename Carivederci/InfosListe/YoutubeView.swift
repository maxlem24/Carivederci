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
                    Text("Notre chaine youtube").font(.title).foregroundColor(Color("Marron")).padding()
                        .frame(width: geometry.size.width, height: geometry.size.height*0.1)
                        .background(Rectangle().fill(Color("RosePale")).cornerRadius(10))
                    Spacer()
                    VStack{
                        Image("Logo").resizable().scaledToFit().frame(height: geometry.size.height*0.4)
                        Link("Notre chaine youtube", destination: URL(string: "https://www.youtube.com/channel/UCVmZCP-YVv5rGx4Iieq-QHg")!).font(.title).accentColor(Color("Marron")).padding()
                        Image("Youtube").resizable().scaledToFit().frame(height: geometry.size.height*0.2)
                    }
                    Spacer()
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
