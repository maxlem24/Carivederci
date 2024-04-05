//
//  Models.swift
//  Carivederci
//
//  Created by Maxime on 18/02/2024.
//



import SwiftUI

struct User : Codable, Equatable{
    let id : String
    let pseudo : String
    var score : Int = 0
    let profil : String
    var famille : Famille?
    var isAdmin :Bool = false
    static func == (left : User, right : User)-> Bool{
        return left.id == right.id && left.pseudo == right.pseudo && left.score == right.score && left.profil == right.profil
    }
    
}

struct Points : Codable {
    let points : Int
}

class AppUser : ObservableObject {
    @Published var user : User?
    @Published var famille : Famille?
    init(user : User) {
        self.user = user
    }
    init() {
        self.user = nil
        self.famille = nil
    }
}

struct User : Codable, Equatable{
    let id : String
    let pseudo : String
    var score : Int = 0
    let profil : String
    var isAdmin :Bool = false
    /*static func == (left : User, right : User)-> Bool{
        return left.id == right.id && left.pseudo == right.pseudo && left.score == right.score && left.profil == right.profil
    }*/
}

struct Famille : Codable{
    let nom : String
    let abbv : String
    var score : Int
}

extension Famille {
    static let famillesExemple : [Famille] = [
        Famille(nom: "Dream Team", abbv: "DRT", score: 1024),
        Famille(nom: "Les Mineurs du Fond", abbv: "MDF", score: 867),
        Famille(nom: "Caripotter", abbv: "CPT", score: 624),
        Famille(nom: "Autre team", abbv: "RDM", score: 444),
        Famille(nom: "Les Fet'arts", abbv: "ART", score: 367),
        Famille(nom: "Les Petits", abbv: "PTT", score: 244),
    ]
}

struct Sponsor : Codable {
    let imageName : String
    let marqueName : String
}

extension Sponsor {
    static let listeSponsor : [Sponsor] = [
        Sponsor(imageName: "Redbull", marqueName: "Redbull"),
        Sponsor(imageName: "Lydia", marqueName: "Lydia"),
        Sponsor(imageName: "osakatoys", marqueName: "Osakatoys"),
        Sponsor(imageName: "briquesrouges", marqueName: "Festival les briques rouges"),
        Sponsor(imageName: "Karos", marqueName: "Karos")
    ]
}
