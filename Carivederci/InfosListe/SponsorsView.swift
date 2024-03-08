//
//  SponsorsView.swift
//  Carivederci
//
//  Created by Maxime on 25/02/2024.
//

import SwiftUI

struct SponsorsView: View {
    var body: some View {
        GeometryReader{
            geometry in
            ScrollView{
                VStack(spacing:0){
                    SponsorBox(imageName: "Redbull", marqueName: "Redbull", backgroundColor: Color.white)
                        .frame(width: geometry.size.width,height: geometry.size.height*0.3)
                    SponsorBox(imageName: "Lydia", marqueName: "Lydia", backgroundColor: Color.white)
                        .frame(width: geometry.size.width,height: geometry.size.height*0.3)
                }
            }
        }
        
    }
}

struct SponsorsView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorsView()
    }
}

struct SponsorBox : View{
    let imageName : String
    let marqueName : String
    let backgroundColor : Color
    var body: some View {
        GeometryReader {
            geometry in
            VStack(spacing:0){
                Image(imageName).resizable().scaledToFit().padding(5)
                    .frame(width: geometry.size.width,height: geometry.size.height*0.9).background(backgroundColor)
                Text(marqueName).bold().font(.headline).foregroundColor(.white).padding(5)
                        .frame(width: geometry.size.width,height: geometry.size.height*0.1)
                        .background(Rectangle().fill(Color("Button")).cornerRadius(5))
            }
        }
    }
    
}
