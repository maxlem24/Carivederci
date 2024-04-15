//
//  ScoreboardView.swift
//  Carivederci
//
//  Created by Maxime on 07/01/2024.
//

import SwiftUI

struct ScoreboardView: View {
    @State var familleList : [Famille] = Famille.famillesExemple
    @State var errorText : String = ""
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color("BlancRosé").ignoresSafeArea()
                VStack{
                    Text("Le classement des familles").font(.title).foregroundColor(Color("Marron")).padding()
                        .frame(width: geometry.size.width, height: geometry.size.height*0.1)
                        .background(Rectangle().fill(Color("RosePale")).cornerRadius(10))
                    Text(errorText).font(.callout).foregroundColor(.red).padding(5)
                    Scoreboard(geometry: geometry,familles: $familleList)
                }
            }
        }.task{
                await getFamilleList()
        }
    }
    func getFamilleList() async {
        guard let url = URL(string : hostName+"/getFamille") else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        var request = URLRequest(url : url)
        request.httpMethod = "GET"
        do{
            let (data,response) = try await URLSession.shared.data(for: request)
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 201 {
                if let decodedResponse = try? JSONDecoder().decode(FamilleList.self, from: data) {
                    familleList = decodedResponse.famille
                }
            } else {
                if let decodedResponse = try? JSONDecoder().decode(Message.self, from: data) {
                    errorText = decodedResponse.message
                }
            }
        } catch {
            errorText = error.localizedDescription
        }
    }
}

struct Scoreboard : View {
    var geometry : GeometryProxy
    @Binding var familles : [Famille]
    var body: some View {
        VStack{
            HStack(alignment :.bottom ,spacing:0){
                let hauteur = geometry.size.height*0.3
                VStack{
                    if familles.indices.contains(1)  {
                        let deuxieme = familles[1]
                        Text("[\(deuxieme.logo)]")
                            .font(.title3).bold()
                            .padding(.horizontal,5)
                        Text("\(deuxieme.nom)")
                            .font(.title3).bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,5)
                        Text("\(deuxieme.score)")
                            .font(.title3).bold()
                            .foregroundColor(Color("Silver")).padding(.horizontal,5)
                    }
                    Rectangle().fill(Color("RoseMedium"))
                        .frame(height: hauteur*2/3)
                }
                VStack{
                    if familles.indices.contains(0)  {
                        let premier = familles[0]
                        Text("[\(premier.logo)]")
                            .font(.title3).bold()
                            .padding(.horizontal,5)
                        Text("\(premier.nom)")
                            .font(.title3).bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,5)
                        Text("\(premier.score)")
                            .font(.title3).bold()
                            .foregroundColor(Color("Gold")).padding(.horizontal,5)
                    }
                    Rectangle().fill(Color("TaupeClair"))
                        .frame(height: hauteur)
                }
                VStack{
                    if familles.indices.contains(2)  {
                        let troisieme = familles[2]
                        Text("[\(troisieme.logo)]")
                            .font(.title3).bold()
                            .padding(.horizontal,5)
                        Text("\(troisieme.nom)")
                            .font(.title3).bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,5)
                        Text("\(troisieme.score)")
                            .font(.title3).bold()
                            .foregroundColor(Color("Bronze")).padding(.horizontal,5)
                    }
                    Rectangle()
                        .fill(Color("RoseMedium")).frame(height: hauteur*2/3)
                }
            }
            .frame(width: geometry.size.width*0.9)
            
            if familles.count > 3 {
                ScrollView(){
                    ForEach(familles[3...].indices, id : \.self){ index in
                        ScoreView(famille : $familles[index])
                            .frame(width : geometry.size.width*0.9, height: geometry.size.height*0.1)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("RosePale")))
                        Spacer()
                    }
                }
            }
            Spacer()
        }
    }
}

struct ScoreView : View {
    @Binding var famille : Famille
    var body: some View {
        HStack{
            Text("[\(famille.logo)] \t \(famille.nom)").bold().foregroundColor(Color("Marron"))
            Spacer()
            Text("\(famille.score)").foregroundColor(Color("Marron"))
        }.padding(.horizontal)
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
    }
}

