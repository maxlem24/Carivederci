//
//  PlanningView.swift
//  Carivederci
//
//  Created by Maxime on 29/12/2023.
//

import SwiftUI

struct PlanningView: View {
    @State private var jour = Jours.Lundi
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                VStack{
                    Text("Cari-calendrier").font(.title)
                    BoutonStack(jour :$jour,geometry: geometry)
                    JourView(jour: $jour,geometry : geometry)
                }.padding()
            }
        }
        
    }
}

struct BoutonStack : View {
    @Binding var jour : Jours
    let geometry : GeometryProxy
    var body: some View {
        HStack(spacing:5){
            ForEach(Jours.allCases, id: \.self) {
                current in
                Button("\(current.rawValue)"){
                    withAnimation(.default) {
                        jour = current
                    }
                }.padding(.horizontal,5).font(.headline).background(Rectangle().fill( jour==current ? Color("Button") : Color("BackgroundColor") )).cornerRadius(8).lineLimit(1).frame(width: geometry.size.width*0.9/5)
            }
            
        }.frame(width: geometry.size.width*0.9).padding(.vertical,5)
        
        
    }
}

struct HeaderView : View {
    let moment : String
    let lineLength : CGFloat
    var body: some View{
        HStack{
            Rectangle().frame(width: lineLength, height: 1)
            Spacer()
            Text(moment).font(.headline)
            Spacer()
            Rectangle().frame(width: lineLength, height: 1)
        }.padding(.horizontal,10)
    }
}

struct JourView : View{
    @Binding var jour : Jours
    let geometry : GeometryProxy
    var body: some View {
        let actuel = Journee.semaine[jour] ?? Journee()
        
        VStack{
            Text("\(jour.rawValue)").font(.title3).bold().padding(.vertical,10).foregroundColor(Color("AccentText")).frame(width :geometry.size.width).background(Rectangle().fill(Color("TitleColor"))).cornerRadius(15)
            ScrollView{
                ActiviteView(nom : "Allos",activites : actuel.Allo, width : geometry.size.width)
                ActiviteView(nom : "Matin",activites : actuel.Matin, width : geometry.size.width)
                ActiviteView(nom : "Midi",activites : actuel.Midi, width : geometry.size.width)
                ActiviteView(nom : "Après Midi",activites : actuel.ApresMidi, width : geometry.size.width)
                ActiviteView(nom : "Soir",activites : actuel.Soir, width : geometry.size.width)
            }.padding(.vertical,10)
        }.frame(width:geometry.size.width*0.9).background(Rectangle().fill(Color("CalendarBackground"))).cornerRadius(15)
    }
}

struct ActiviteView : View {
    let nom : String
    let activites : [Activite]
    let width : CGFloat
    var body: some View {
        if (activites.count != 0){
            VStack{
                HeaderView(moment: nom, lineLength: width*0.25)
                ForEach(activites) {activite in
                    VStack{
                        Text(activite.nom).font(.body).bold()
                        if activite.lieu != "" {
                            Text(activite.lieu).font(.body)
                        }
                        if activite.heure != "" {
                            Text(activite.heure).font(.body)
                        }
                    }.padding(.vertical,10).frame(width: width*0.8).background(Color("ActiviteBackground")).cornerRadius(10).padding(5)
                }
            }
        }
    }
}