//
//  PlanningView.swift
//  Carivederci
//
//  Created by Maxime on 29/12/2023.
//

import SwiftUI



struct PlanningView: View {
    @State private var size : CGSize = .zero
    @State private var jour = Jours.Lundi
    var body: some View {
        ScrollView{
            VStack{
                Text("Cari-calendrier").font(.headline)
                BoutonStack(jour :$jour)
                jourView(jour: $jour)
                
            }.padding()
            .frame(alignment:.top)
        }.background(Color("BackgroundColor"))
        
    }
}

struct PlanningView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningView()
    }
}

struct BoutonStack : View {
    @Binding var jour : Jours
    var body: some View {
        HStack{
            ForEach(Jours.allCases, id: \.self) {
                current in
                Button("\(current.rawValue)"){
                    jour = current
                }.padding(5).font(.footnote).background(Rectangle().fill( jour==current ? Color.gray : Color("BackgroundColor") )).cornerRadius(10).lineLimit(1)
            }
            
        }.padding().frame(width: 300)
    }
}

struct jourView : View{
    @Binding var jour : Jours
    @State private var size : CGSize = .zero
    var body: some View {
        let actuel = Journee.semaine[jour]
        
        VStack{
            Text("\(jour.rawValue)").font(.subheadline).foregroundColor(Color("AccentText")).frame(width :300,height: 50).background(Rectangle().fill(Color("TitleColor"))).cornerRadius(15)
            HStack{
                Rectangle().frame(width: 75, height: 1)
                Spacer()
                Text("Matin")
                Spacer()
                Rectangle().frame(width: 75, height: 1)
            }.padding(5)
            VStack{
                Text("\(actuel?.Matin.nom ?? "")")
                Text("\(actuel?.Matin.lieu ?? "")")
                Text("\(actuel?.Matin.heure ?? "")")
            }
            HStack{
                Rectangle().frame(width: 75, height: 1)
                Spacer()
                Text("Midi")
                Spacer()
                Rectangle().frame(width: 75, height: 1)
            }.padding(5)
            
            VStack{
                Text("\(actuel?.Midi.nom ?? "")")
                Text("\(actuel?.Midi.lieu ?? "")")
                Text("\(actuel?.Midi.heure ?? "")")
            }
            HStack{
                Rectangle().frame(width: 75, height: 1)
                Spacer()
                Text("Après Midi")
                Spacer()
                Rectangle().frame(width: 75, height: 1)
            }.padding(5)
            VStack{
                Text("\(actuel?.ApresMidi.nom ?? "")")
                Text("\(actuel?.ApresMidi.lieu ?? "")")
                Text("\(actuel?.ApresMidi.heure ?? "")")
            }.scaledToFill().padding().background(Rectangle().fill(Color("BackgroundColor")))
            
            HStack{
                Rectangle().frame(width: 75, height: 1)
                Spacer()
                Text("Soir")
                Spacer()
                Rectangle().frame(width: 75, height: 1)
            }.padding(5)
            VStack{
                Text("\(actuel?.Soir.nom ?? "")")
                Text("\(actuel?.Soir.lieu ?? "")")
                Text("\(actuel?.Soir.heure ?? "")")
            }
        }.background(Rectangle().fill(Color("CalendarBackground"))).cornerRadius(15)
    }
}
