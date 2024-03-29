//
//  ScoreboardView.swift
//  Carivederci
//
//  Created by Maxime on 07/01/2024.
//

import SwiftUI

struct ScoreboardView: View {
    @State var familleList : [Famille] = Famille.famillesExemple
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color("BlancRosé").ignoresSafeArea()
                Scoreboard(geometry: geometry,familles: familleList)
            }
        }
    }
}

struct Scoreboard : View {
    var geometry : GeometryProxy
    @State var familles : [Famille]
    var body: some View {
        VStack{
            Podium(premier: familles.indices.contains(0) ? familles[0] : nil,
                   deuxieme: familles.indices.contains(1) ? familles[1] : nil,
                   troisieme: familles.indices.contains(2) ? familles[2] : nil,
                   hauteur: geometry.size.height*0.3).frame(width: geometry.size.width*0.9)
            
            if familles.count > 3 {
                ScrollView(){
                    ForEach(3..<familles.count){ index in
                        ScoreView(famille : familles[index])
                            .frame(width : geometry.size.width*0.9, height: geometry.size.height*0.1)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("Taupe")))
                    }
                }
            }
            Spacer()
        }
    }
}

struct ScoreView : View {
    @State var famille : Famille
    var body: some View {
        HStack{
            Text("[\(famille.abbv)] \t \(famille.nom)").bold()
            Spacer()
            Text("\(famille.score)")
        }.padding(.horizontal)
    }
}

struct Podium : View {
    @State var premier : Famille?
    @State var deuxieme : Famille?
    @State var troisieme : Famille?
    var hauteur : CGFloat
    var body: some View {
        HStack(alignment :.bottom ,spacing:0){
            VStack{
                if deuxieme != nil {
                    Text("[\(deuxieme!.abbv)]")
                        .font(.title3).bold()
                        .padding(.horizontal,5)
                    Text("\(deuxieme!.nom)")
                        .font(.title3).bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,5)
                    Text("\(deuxieme!.score)")
                        .font(.title3).bold()
                        .foregroundColor(Color("Silver")).padding(.horizontal,5)
                }
                Rectangle().fill(Color("Rose"))
                    .frame(height: hauteur*2/3)
            }
            VStack{
                if premier != nil {
                    Text("[\(premier!.abbv)]")
                        .font(.title3).bold()
                        .padding(.horizontal,5)
                    Text("\(premier!.nom)")
                        .font(.title3).bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,5)
                    Text("\(premier!.score)")
                        .font(.title3).bold()
                        .foregroundColor(Color("Gold")).padding(.horizontal,5)
                }
                Rectangle().fill(Color("PurpleBrown"))
                    .frame(height: hauteur)
            }
            VStack{
                if troisieme != nil {
                    Text("[\(troisieme!.abbv)]")
                        .font(.title3).bold()
                        .padding(.horizontal,5)
                    Text("\(troisieme!.nom)")
                        .font(.title3).bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,5)
                    Text("\(troisieme!.score)")
                        .font(.title3).bold()
                        .foregroundColor(Color("Bronze")).padding(.horizontal,5)
                }
                Rectangle()
                    .fill(Color("Rose")).frame(height: hauteur*2/3)
            }
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
    }
}

