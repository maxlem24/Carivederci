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
                VStack{
                    Text("Nos pôles").font(.title).foregroundColor(Color("Marron")).padding()
                        .frame(width: geometry.size.width, height: geometry.size.height*0.1)
                        .background(Rectangle().fill(Color("RosePale")).cornerRadius(10))
                    ScrollView{
                        Group{
                            TeamBox(teamName: "Bureau", imageName: "Bureau", teamText: description["Bureau"]!,geometry: geometry)
                            TeamBox(teamName: "Team BDS", imageName: "BDS", teamText: description["BDS"]!,geometry: geometry)
                            TeamBox(teamName: "Team BDA", imageName: "BDA", teamText: description["BDA"]!,geometry: geometry)
                            TeamBox(teamName: "Team Soirée", imageName: "Soirée", teamText: description["Soirée"]!,geometry: geometry)
                            TeamBox(teamName: "Team Com", imageName: "Com", teamText: description["Com"]!,geometry: geometry)
                        }
                        TeamBox(teamName: "Team BDI", imageName: "BDI", teamText: description["BDI"]!,geometry: geometry)
                        TeamBox(teamName: "Team Assos et Club", imageName: "Asso", teamText: description["Asso"]!,geometry: geometry)
                        TeamBox(teamName: "Team Opé", imageName: "Opé", teamText: description["Opé"]!,geometry: geometry)
                        TeamBox(teamName: "Team Partenariats", imageName: "Partenariats", teamText: description["Partenariats"]!,geometry: geometry)
                        TeamBox(teamName: "Team FISA", imageName: "FISA", teamText: description["FISA"]!,geometry: geometry)
                        TeamBox(teamName: "AEI", imageName: "AEI", teamText: description["AEI"]!,geometry: geometry)
                        Spacer()
                    }
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
        
        VStack(spacing:10){
            HStack{
                Rectangle().frame(width: geometry.size.width*0.25, height: 1)
                Spacer()
                Text(teamName).font(.headline).multilineTextAlignment(.center)
                Spacer()
                Rectangle().frame(width: geometry.size.width*0.25, height: 1)
            }
            HStack(alignment: .top){
                Image(imageName).resizable().scaledToFit()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                    .frame(width: geometry.size.width*0.45).fixedSize(horizontal: false, vertical: true)
                Text(teamText).font(.body)
                    .frame(width: geometry.size.width*0.45).fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
}


let description : [String : String] = [
    "Bureau" :
        "Redoutable et redouté, le bureau règne sur Valenciennes et protège la famille Cari à n’importe quel prix.",
    
    "BDI":
        "Ils codent plus qu’ils ne parlent italien, la team BDI vous montrera que la campagne est aussi numérique.",
    
    "Soirée":
        "Cari ciao ! Ils règnent sur la noche de Valenciennes en organisant les fêtes les plus déjantées. Leurs clients VIP sont les Insaiens qu’ils régalent jusqu’au petit matin.",
    
    "BDA" :
        "Ils adorent Maneskin et écouter ‘Sara perché ti amo’, mais ce qu’ils aiment par-dessus tout, c’est réunir les meilleurs artistes de Valenciennes pour vous en mettre plein les yeux.",
    
    "BDS" :
        "Les gros bras de la famille arrivent en force ! Le BDS est prêt à relever tous les défis sportifs que vous leur proposerez.",
    
    "Asso" :
        "Les passes temps des carivederci ne sont pas tous illégaux, la preuve, on les retrouve avec les amici des Asso et clubs.",
    
    "Com" :
        "Véritables indics de la famille, les membres de cette team sont au courant de tout avant tout le monde et comptent bien vous tenir au courant des news cette semaine",
    
    "Partenariats" :
        "Cette team a certainement dû tremper dans des magouilles afin de vous dégoter les meilleures sponsors et collab !",
    
    "Opé" :
        "Les chefs personnels de la famille cari vous ont concocté les meilleurs opés, afin de vous régaler tout le long de la semaine. Préparez vous à découvrir la Cucina, la vraie !",
    
    "FISA":
        "Les membres les plus professionnels de la famille, ils opèrent à l’intérieur de leur entreprise pour garantir les intérêts des Carivederci.",
    
    "AEI":
        "Elle s’occupe de garantir la bonne entente entre les différentes famiglia de l’INSA, notre chère responsable AEI."
]
