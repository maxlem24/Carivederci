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
        VStack{
            Text("cari-calendrier").font(.subheadline)
            BoutonStack(jour :$jour)
            
        }.padding()
        .scaledToFill()
        .scaledToFit()
        .background(Color("BackgroundColor"))
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
                }.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)).font(.subheadline).background(jour==current ? Color.gray : Color("BackgroundColor") ).cornerRadius(10)
            }
           
        }.padding()
    }
    
}
