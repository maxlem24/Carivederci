//
//  PlanningStruct.swift
//  Carivederci
//
//  Created by Maxime on 29/12/2023.
//

import Foundation

enum Jours : String,CaseIterable {
    case Lundi
    case Mardi
    case Mercredi
    case Jeudi
    case Vendredi
}

struct Activite {
    let heure : String
    let lieu : String
    let nom : String
}

struct Journee {
    let Jour : Jours
    let Matin : Activite
    let Midi : Activite
    let ApresMidi : Activite
    let Soir : Activite
}

extension Journee {
    static let semaine : [Journee] = [
        Journee(Jour: .Lundi, Matin: Activite(heure: "10", lieu: "CLJ1",nom: "Course en sac"), Midi: Activite(heure: "12", lieu: "CLJ2",nom: "Ope Burger"), ApresMidi: Activite(heure: "14", lieu: "CLJ1",nom:"Allo Coiffeur"), Soir: Activite(heure: "20", lieu: "Aquabar",nom: "Talent Show")),
        Journee(Jour: .Mardi, Matin: Activite(heure: "10", lieu: "CLJ1",nom: "Course en sac"), Midi: Activite(heure: "12", lieu: "CLJ2",nom: "Ope Burger"), ApresMidi: Activite(heure: "14", lieu: "CLJ1",nom:"Allo Coiffeur"), Soir: Activite(heure: "20", lieu: "Aquabar",nom: "Talent Show")),
        Journee(Jour: .Mercredi, Matin: Activite(heure: "10", lieu: "CLJ1",nom: "Course en sac"), Midi: Activite(heure: "12", lieu: "CLJ2",nom: "Ope Burger"), ApresMidi: Activite(heure: "14", lieu: "CLJ1",nom:"Allo Coiffeur"), Soir: Activite(heure: "20", lieu: "Aquabar",nom: "Talent Show")),
        Journee(Jour: .Jeudi, Matin: Activite(heure: "10", lieu: "CLJ1",nom: "Course en sac"), Midi: Activite(heure: "12", lieu: "CLJ2",nom: "Ope Burger"), ApresMidi: Activite(heure: "14", lieu: "CLJ1",nom:"Allo Coiffeur"), Soir: Activite(heure: "20", lieu: "Aquabar",nom: "Talent Show")),
        Journee(Jour: .Vendredi, Matin: Activite(heure: "10", lieu: "CLJ1",nom: "Course en sac"), Midi: Activite(heure: "12", lieu: "CLJ2",nom: "Ope Burger"), ApresMidi: Activite(heure: "14", lieu: "CLJ1",nom:"Allo Coiffeur"), Soir: Activite(heure: "20", lieu: "Aquabar",nom: "Talent Show"))
    ]
}



