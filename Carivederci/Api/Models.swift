//
//  Models.swift
//  Carivederci
//
//  Created by Maxime on 18/02/2024.
//



import SwiftUI


class AppUser : ObservableObject {
    static let shared : AppUser = AppUser()
    
    private var user : User? = nil
    private var famille : Famille? = nil
    
    private init() {
    }
    
    func getUser() -> User? {
        return user
    }
    
    func getFamille() -> Famille? {
        return famille
    }
    
    func setUser(user : User?) {
        self.user = user
    }
    
    func setFamille(famille : Famille?) {
        self.famille = famille
    }
}

struct User : Codable {
    let pseudo : String
    var score : Int = 0
    var isAdmin : Bool = false
}

struct Famille : Codable{
    let nom : String
    let abbv : String
    var score : Int = 0
}

extension Famille {
    static let famillesExemple : [Famille] = [
        Famille(nom: "Carivederci", abbv: "CVD", score: 2024),
        Famille(nom: "Dream Team", abbv: "DRT", score: 1024),
        Famille(nom: "Les Mineurs du Fond", abbv: "MDF", score: 867),
        Famille(nom: "Caripotter", abbv: "CPT", score: 624),
        Famille(nom: "Autre team", abbv: "RDM", score: 444),
        Famille(nom: "Les Fet'arts", abbv: "ART", score: 367),
        Famille(nom: "Les Petits", abbv: "PTT", score: 244),
    ]
}

struct Sponsor  {
    let imageName : String
    let marqueName : String
}

extension Sponsor {
    static let listeSponsor : [Sponsor] = [
        Sponsor(imageName: "Redbull", marqueName: "Redbull"),
        Sponsor(imageName: "Lydia", marqueName: "Lydia"),
        Sponsor(imageName: "Osakatoys", marqueName: "Osakatoys"),
        Sponsor(imageName: "Briques Rouges", marqueName: "Festival les briques rouges"),
        Sponsor(imageName: "Karos", marqueName: "Karos"),
        Sponsor(imageName: "Intersport", marqueName: "Intersport"),
        Sponsor(imageName: "Leon", marqueName: "Léon de Bruxelles"),
        Sponsor(imageName: "Murder", marqueName: "France Murder"),
        Sponsor(imageName: "Pixelbar", marqueName: "Pixelbar"),
        Sponsor(imageName: "Reload", marqueName: "Reload"),
        Sponsor(imageName: "Via Ristorante", marqueName: "Via Ristorante"),
        Sponsor(imageName: "VNB Arsenal", marqueName: "V&B Arsenal"),
        Sponsor(imageName: "VNB Aulnoy", marqueName: "V&B Aulnoy-lez-Valenciennes"),
    ]
}

struct Message : Codable {
    let message : String
}

struct Score : Codable {
    let score : Int
}

struct QrCode : Codable {
    let qrcode : String
}

struct FamilleAPI : Codable {
    let name : String
    let logo : String?
    let password : String
    let repeatPassword : String?
}

struct UserAPI : Codable {
    let username : String
    let nom : String?
    let prenom : String?
    let email : String?
    let password : String
    let repeatPassword : String?
}

struct APIConnect : Codable {
    let user : User
    let token : String
}
