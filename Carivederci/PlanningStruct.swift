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
    let Matin : Activite
    let Midi : Activite
    let ApresMidi : Activite
    let Soir : Activite
}

extension Journee {
    static let semaine : [Jours : Journee] = [
        Jours.Lundi : Journee( Matin: Activite(heure: "10h00", lieu: "CLJ1",nom: "Course en sac"), Midi: Activite(heure: "12h00", lieu: "CLJ2",nom: "Ope Burger"), ApresMidi: Activite(heure: "14h00", lieu: "CLJ1",nom:"Allo Coiffeur"), Soir: Activite(heure: "20h00", lieu: "Aquabar",nom: "Talent Show")),
        Jours.Mardi : Journee( Matin: Activite(heure: "10", lieu: "CLJ1",nom: "Course en sac"), Midi: Activite(heure: "12", lieu: "CLJ2",nom: "Ope Burger"), ApresMidi: Activite(heure: "14", lieu: "CLJ1",nom:"Allo Coiffeur"), Soir: Activite(heure: "20", lieu: "Aquabar",nom: "Talent Show")),
        Jours.Mercredi : Journee( Matin: Activite(heure: "10", lieu: "CLJ1",nom: "Course en sac"), Midi: Activite(heure: "12", lieu: "CLJ2",nom: "Ope Burger"), ApresMidi: Activite(heure: "14", lieu: "CLJ1",nom:"Allo Coiffeur"), Soir: Activite(heure: "20", lieu: "Aquabar",nom: "Talent Show")),
        Jours.Jeudi :Journee( Matin: Activite(heure: "10", lieu: "CLJ1",nom: "Course en sac"), Midi: Activite(heure: "12", lieu: "CLJ2",nom: "Ope Burger"), ApresMidi: Activite(heure: "14", lieu: "CLJ1",nom:"Allo Coiffeur"), Soir: Activite(heure: "21", lieu: "Nympheas",nom: "Cari-Soirée")),
        Jours.Vendredi : Journee( Matin: Activite(heure: "10", lieu: "CLJ1",nom: "Course en sac"), Midi: Activite(heure: "12", lieu: "CLJ2",nom: "Ope Burger"), ApresMidi: Activite(heure: "14", lieu: "CLJ1",nom:"Allo Coiffeur"), Soir: Activite(heure: "20", lieu: "Aquabar",nom: "Talent Show"))
    ]
}



