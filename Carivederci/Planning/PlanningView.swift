//
//  PlanningView.swift
//  Carivederci
//
//  Created by Maxime on 29/12/2023.
//

import SwiftUI

struct PlanningView: View {
    @State var jour : Jours = Jours.Lundi
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                ZStack{
                    Color("BlancRosé").ignoresSafeArea()
                    VStack{
                        HStack{
                            Spacer()
                            NavigationLink(destination :
                                            QRScannerView()
                                           ,label: {
                                Image(systemName: "qrcode").resizable().scaledToFit().foregroundColor(Color("BlancRosé")).padding().frame(width: geometry.size.width*0.2, height: geometry.size.width*0.2)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("Bordeaux")))
                            })
                            Spacer()
                        }
                        Link("Le standard",destination: URL(string: "tel:+33366596050")!).font(.title)
                            .padding(5).background(RoundedRectangle(cornerRadius: 8)
                                .fill( Color("Taupe")) )
                            .frame(width: geometry.size.width*0.5)                       
                        BoutonStack(jour :$jour,geometry: geometry)
                        JourView(jour: $jour,geometry : geometry)
                    }.padding()
                }
            }
        }.edgesIgnoringSafeArea([.top, .bottom])
            .task{
            jour = getDay()
        }
    }
    func getDay() -> Jours {
        let jour = Date().formatted(Date.FormatStyle().weekday(.oneDigit))
        switch jour {
        case "1","2":
            return .Lundi
        case "3":
            return .Mardi
        case "4":
            return .Mercredi
        case "5" :
            return .Jeudi
        default :
            return .Vendredi
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
                }.foregroundColor(.black).padding(.horizontal,5).font(.headline).background(Rectangle().fill( jour==current ? Color("Taupe") : Color("BlancRosé") )).cornerRadius(8).lineLimit(1).frame(width: geometry.size.width*0.9/5)
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
            Text("\(jour.rawValue)").font(.title3).bold().padding(.vertical,10).foregroundColor(Color("RoseBlanc")).frame(width :geometry.size.width).background(Rectangle().fill(Color("PurpleBrown"))).cornerRadius(15)
            ScrollView{
                ActiviteView(nom : "Allos",activites : actuel.Allo, width : geometry.size.width)
                ActiviteView(nom : "Matin",activites : actuel.Matin, width : geometry.size.width)
                ActiviteView(nom : "Midi",activites : actuel.Midi, width : geometry.size.width)
                ActiviteView(nom : "Après Midi",activites : actuel.ApresMidi, width : geometry.size.width)
                ActiviteView(nom : "Soir",activites : actuel.Soir, width : geometry.size.width)
            }.padding(.vertical,10)
        }.frame(width:geometry.size.width*0.9).background(Rectangle().fill(Color("Rose"))).cornerRadius(15)
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
                    }.padding(.vertical,10).frame(width: width*0.8).background(Color("RoseMedium")).cornerRadius(10).padding(5)
                }
            }
        }
    }
}
