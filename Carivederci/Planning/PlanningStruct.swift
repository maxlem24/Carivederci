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

struct Activite : Identifiable{
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
                    Midi: [Activite(nom: "Tournoi Smash"),Activite(nom: "Questions pour un Mafieux"),Activite(nom : "Activités sportives du BDS"),Activite(nom: "Concert BDA")],
                    Soir: [Activite(nom: "Drame à Chicago"),Activite(nom: "Carinostra", lieu: "Le Hï")]
                ),
                Jours.Mardi : Journee(
                    Allo : [Activite(nom:"Allo Exfiltration"),Activite(nom:"Allo Mugshot")],
                    Matin: [Activite(nom: "Petit Dej")],
                    Midi: [Activite(nom: "Tournoi Smash"), Activite(nom: "Questions pour un Mafieux"), Activite(nom : "Activités sportives du BDS"),Activite(nom: "Fresque BDA")],
                    Soir: [Activite(nom: "Carick'n'Roll",lieu: "L'Imaginaire"), Activite(nom: "Allo Turn-up")]
                ),
                Jours.Mercredi : Journee(
                    Allo : [Activite(nom:"Allo Body Guard")],
                    Matin: [Activite(nom: "Petit Dej")],
                    Midi: [Activite(nom: "Tournoi Smash"), Activite(nom: "Questions pour un Mafieux"), Activite(nom : "Activités sportives du BDS"), Activite(nom: "Just Dance"),Activite(nom: "Opé Allié/Ennemi")],
                    Soir: [Activite(nom: "Talent Show",lieu: "V&B l'Arsenal"), Activite(nom: "Apéro Visio")]
                ),
                Jours.Jeudi :Journee(
                    Allo: [Activite(nom : "Allo Tattoo")],
                    Matin: [Activite(nom: "Petit Dej")],
                    Midi: [Activite(nom: "Tournoi Smash"), Activite(nom: "Questions pour un Mafieux"), Activite(nom: "Projection de film")],
                    ApresMidi: [Activite(nom:"Après midi BDS",lieu : "Etang du Vignoble")],
                    Soir: [Activite(nom: "La nuit des Parrains", lieu: "Rêve d'Ô")]
                ),
                Jours.Vendredi : Journee(
                    Matin: [Activite(nom: "Petit Dej")],
                    Midi: [Activite(nom: "Finale du tournoi Smash"),Activite(nom: "Finale de Questions pour un Mafieux"),Activite(nom : "Activités sportives du BDS")],
                    ApresMidi: [Activite(nom:"Remise des lots")],
                    Soir: [Activite(nom:"L'Omerta",  lieu: "Pixel")]
                )
    ]
}
