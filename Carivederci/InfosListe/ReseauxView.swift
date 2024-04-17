//
//  LogoView.swift
//  Carivederci
//
//  Created by Maxime on 25/02/2024.
//

import SwiftUI

struct ReseauxView: View {
    var body: some View {
        GeometryReader{
            geometry in
            ZStack(alignment: .center) {
                Color("BlancRosé").ignoresSafeArea()
                VStack{
                    Text("Nos réseaux").font(.title).foregroundColor(Color("Marron")).padding()
                        .frame(width: geometry.size.width, height: geometry.size.height*0.1)
                        .background(Rectangle().fill(Color("RosePale")).cornerRadius(10))
                    Spacer()
                    VStack{
                        HStack{
                            Reseau(imageName: "Youtube", lien: URL(string : "https://www.youtube.com/channel/UCVmZCP-YVv5rGx4Iieq-QHg")!, nom: "Notre chaine Youtube", geometry: geometry).frame(width: geometry.size.width*0.5)
                            Reseau(imageName: "Insta", lien: URL(string: "https://www.instagram.com/carivederci")!, nom: "Notre Insta", geometry: geometry).frame(width : geometry.size.width*0.5)
                        }
                        HStack{
                            Reseau(imageName: "BeReal", lien: URL(string : "https://bere.al/carivederci")!, nom: "Notre BeReal", geometry: geometry).frame(width: geometry.size.width*0.5)
                            Reseau(imageName: "TikTok", lien: URL(string: "https://www.tiktok.com/@carivederci")!, nom: "Notre TikTok", geometry: geometry).frame(width : geometry.size.width*0.5)
                        }                    }
                    Spacer()
                }
            }
        }
    }
}

struct Reseau :View {
    let imageName : String
    let lien : URL
    let nom : String
    let geometry : GeometryProxy
    var body: some View{
        VStack(alignment : .center){
            Image(imageName).resizable().scaledToFit().frame(width : geometry.size.width/6, height:  geometry.size.width/6).clipShape(RoundedRectangle(cornerRadius: 5))
            Link(nom, destination: lien).font(.headline).accentColor(Color("Marron")).padding()
        }
    }
}

