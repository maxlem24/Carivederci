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
                ScrollView{
                    VStack{
                        Text("Cari-calendrier").font(.title)
                        BoutonStack(jour :$jour,geometry: geometry)
                        jourView(jour: $jour,geometry : geometry)
                        
                    }.padding()
                    .frame(alignment:.top)
                }
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
                    jour = current
                }.padding(.horizontal,5).font(.headline).background(Rectangle().fill( jour==current ? Color("Button") : Color("BackgroundColor") )).cornerRadius(8).lineLimit(1).frame(width: geometry.size.width*0.9/5)
            }
            
        }.frame(width: geometry.size.width*0.9).padding(.vertical,5)
        
        
    }
}

struct jourView : View{
    @Binding var jour : Jours
    let geometry : GeometryProxy
    var body: some View {
        let actuel = Journee.semaine[jour]
        
        let lineLength = geometry.size.width/4
        VStack{
            Text("\(jour.rawValue)").font(.title3).bold().padding(.vertical,10).foregroundColor(Color("AccentText")).frame(width :geometry.size.width).background(Rectangle().fill(Color("TitleColor"))).cornerRadius(15)
            HStack{
                Rectangle().frame(width: lineLength, height: 1)
                Spacer()
                Text("Matin").font(.headline)
                Spacer()
                Rectangle().frame(width: lineLength, height: 1)
            }.padding(.horizontal,10)
            activiteView(activite: actuel!.Matin,width: geometry.size.width)
            HStack{
                Rectangle().frame(width: lineLength, height: 1)
                Spacer()
                Text("Midi").font(.headline)
                Spacer()
                Rectangle().frame(width: lineLength, height: 1)
            }.padding(.horizontal,10)
            
            activiteView(activite: actuel!.Midi,width: geometry.size.width)
            HStack{
                Rectangle().frame(width: lineLength, height: 1)
                Spacer()
                Text("Après Midi").font(.headline)
                Spacer()
                Rectangle().frame(width: lineLength, height: 1)
            }.padding(.horizontal,10)
            activiteView(activite: actuel!.ApresMidi,width: geometry.size.width)
            
            HStack{
                Rectangle().frame(width: lineLength, height: 1)
                Spacer()
                Text("Soir").font(.headline)
                Spacer()
                Rectangle().frame(width: lineLength, height: 1)
            }.padding(.horizontal,10)
            activiteView(activite: actuel!.Soir,width: geometry.size.width)
            Spacer()
        }.frame(width:geometry.size.width*0.9).background(Rectangle().fill(Color("CalendarBackground"))).cornerRadius(15)
        
    }
}

struct activiteView : View {
    let activite : Activite
    let width : CGFloat
    var body: some View {
        
        VStack{
            Text("\(activite.nom)").font(.body)
            Text("\(activite.lieu)").font(.body)
            Text("\(activite.heure)").font(.body)
        }.padding(5).frame(width: width*0.8).background(Color("ActiviteBackground")).cornerRadius(10).padding(5)
        
    }
}
