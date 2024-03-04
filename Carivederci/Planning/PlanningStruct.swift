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

struct Activite :Identifiable{
    var id : String {
        return nom
    }
    let nom : String
    var heure : String = ""
    var lieu : String = ""
}

struct Journee {
    var Allo : [Activite] = [ ]
    var Matin : [Activite] = [ ]
    var Midi : [Activite] = [ ]
    var ApresMidi : [Activite] = [ ]
    var Soir : [Activite] = [ ]
}

extension Journee {
    static let semaine : [Jours : Journee] = [
        Jours.Lundi : Journee(
            Allo : [Activite(nom :"Allo Turn-Up"),Activite(nom: "Allo Crêpes")],
            Midi: [Activite(nom: "Jeu du midi"),Activite(nom: "Concert BDA", lieu: "Hall CLJ1")],
            ApresMidi: [Activite( nom: "Création des Familles")],
            Soir: [Activite(nom: "Murder Party"),Activite(nom: "Olympiades", lieu: "L'incontournable")]
        ),
        Jours.Mardi : Journee(
            Allo : [Activite(nom:"Allo Enlevement"),Activite(nom:"Allo Mugshot")],
            Midi: [Activite(nom: "Jeu du midi"),Activite(nom: "Fresque BDA")],
            Soir: [Activite(nom: "Nympheas Bis")]
        ),
        Jours.Mercredi : Journee(
            Allo : [Activite(nom:"Allo Body Guard")],
            Matin: [Activite(nom: "Opé Allié/Ennemi")],
            Midi: [Activite(nom: "Jeu du midi"),Activite(nom: "Just Dance")],
            ApresMidi: [Activite(nom: "Opé Allié/Ennemi")],
            Soir: [Activite(nom: "Talent Show")]
        ),
        Jours.Jeudi :Journee(
            Allo: [Activite(nom : "Allo Tattoo")],
            Midi: [Activite(nom: "Jeu du midi"),Activite(nom: "Projection de film",lieu: "CLJ3-E14")],
            ApresMidi: [Activite(nom:"Après midi BDS")],
            Soir: [Activite(nom: "Soirée", lieu: "Reves d'Ô")]
        ),
        Jours.Vendredi : Journee(
            Midi: [Activite(nom: "Finale des jeux du midi")],
            ApresMidi: [Activite(nom:"Remise des lots", heure: "14h30", lieu: "CLJ3-E14")],
            Soir: [Activite(nom: "Laser Game"),Activite(nom:"Afterwork",lieu: "Pixel Bar")]
        )
    ]
}



