//
//  TeamsView.swift
//  Carivederci
//
//  Created by Maxime on 25/02/2024.
//

import SwiftUI

struct TeamsView: View {
    var body: some View {
        GeometryReader{
            geometry in
        
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                ScrollView{
                    TeamBox(teamName: "Le bureau", imageName: "Team", teamText: description[0],geometry: geometry)
                    TeamBox(teamName: "BDI", imageName: "Team", teamText: description[1],geometry: geometry)
                }
            }
        }
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
    }
}

struct TeamBox : View{
    let teamName : String
    let imageName : String
    let teamText : String
    let geometry : GeometryProxy
    var body: some View {
        
            VStack(){
                HStack{
                    Rectangle().frame(width: geometry.size.width*0.3, height: 1)
                    Spacer()
                    Text(teamName).font(.headline)
                    Spacer()
                    Rectangle().frame(width: geometry.size.width*0.3, height: 1)
                }
                HStack{
                    Image(imageName).resizable().scaledToFit()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                        .frame(width: geometry.size.width*0.45).fixedSize(horizontal: false, vertical: true)
                    Text(teamText).font(.body).fixedSize(horizontal: false, vertical: true).frame(width: geometry.size.width*0.45)
                }
            }.padding(10)
        
    }
    
}


let description : [String] = [
"Le bureau Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet blandit egestas. Nunc odio elit, maximus vitae volutpat non, porta nec orci. Integer est odio, bibendum ut lorem id, varius imperdiet ipsum. ",
    "Le BDI, les meilleurs, sans me vanter bien sur"
]
