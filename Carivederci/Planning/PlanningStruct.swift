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
            Midi: [Activite(nom: "Tournoi Smash"),Activite(nom: "Question pour un Mafieux"),Activite(nom : "Activités sportives du BDS"),Activite(nom: "Concert BDA", lieu: "Hall CLJ1")],
            Soir: [Activite(nom: "Murder Party"),Activite(nom: "Carinostra", lieu: "Le HI")]
        ),
        Jours.Mardi : Journee(
            Allo : [Activite(nom:"Allo Enlevement"),Activite(nom:"Allo Mugshot")],
            Midi: [Activite(nom: "Tournoi Smash"), Activite(nom: "Question pour un Mafieux"), Activite(nom : "Activités sportives du BDS"),Activite(nom: "Fresque BDA")],
            Soir: [Activite(nom: "Carick'n'Roll",lieu: "L'imaginaire"), Activite(nom: "Allo Turn-up")]
        ),
        Jours.Mercredi : Journee(
            Allo : [Activite(nom:"Allo Body Guard")],
            Matin: [Activite(nom: "Opé Allié/Ennemi")],
            Midi: [Activite(nom: "Tournoi Smash"), Activite(nom: "Question pour un Mafieux"), Activite(nom : "Activités sportives du BDS"), Activite(nom: "Just Dance"),Activite(nom: "Opé Allié/Ennemi")],
            Soir: [Activite(nom: "Talent Show")]
        ),
        Jours.Jeudi :Journee(
            Allo: [Activite(nom : "Allo Tattoo")],
            Midi: [Activite(nom: "Tournoi Smash"),Activite(nom: "Question pour un Mafieux"), Activite(nom : "Activités sportives du BDS"),Activite(nom: "Projection de film")],
            ApresMidi: [Activite(nom:"Après midi BDS")],
            Soir: [Activite(nom: "La nuit des Parrains", lieu: "Reves d'Ô")]
        ),
        Jours.Vendredi : Journee(
            Midi: [Activite(nom: "Finale des jeux du midi")],
            ApresMidi: [Activite(nom:"Remise des lots",  lieu: "CLJ3-E14")],
            Soir: [Activite(nom:"Omerta", lieu: "Pixel Bar")]
        )
    ]
}



