//
//  SponsorsView.swift
//  Carivederci
//
//  Created by Maxime on 25/02/2024.
//

import SwiftUI

struct SponsorsView: View {
    var sponsors = Sponsor.listeSponsor
    var body: some View {
        GeometryReader{
            geometry in
            ScrollView{
                let isEven = sponsors.count % 2 == 0
                ForEach(0..<sponsors.count/2){index in
                    HStack{
                        let SponsorLeft = sponsors[2*index]
                        let SponsorRight = sponsors[2*index+1]
                        SponsorBox(imageName: SponsorLeft.imageName, marqueName: SponsorLeft.marqueName).frame(height: geometry.size.height*0.3)
                        SponsorBox(imageName: SponsorRight.imageName, marqueName: SponsorRight.marqueName).frame(height: geometry.size.height*0.3)
                    }.padding(5)
                }
                if !isEven {
                    let lastSponsor = sponsors[sponsors.count-1]
                    SponsorBox(imageName: lastSponsor.imageName, marqueName: lastSponsor.marqueName).frame(width: geometry.size.width/2,height: geometry.size.height*0.3)
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
    var body: some View {
        GeometryReader {
            geometry in
            VStack(spacing:0){
                Image(imageName).resizable().scaledToFit().padding(5)
                    .frame(height: geometry.size.height*0.8)
                Text(marqueName).bold().font(.headline).foregroundColor(.white).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).padding(5)
                        .frame(width: geometry.size.width,height: geometry.size.height*0.2)
                        .background(Rectangle().fill(Color("Button")).cornerRadius(5))
            }
        }
    }
    
}
