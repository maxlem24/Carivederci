//
//  Models.swift
//  Carivederci
//
//  Created by Maxime on 18/02/2024.
//



import SwiftUI


class AppUser : ObservableObject {
    static let shared : AppUser = AppUser()
    
    @Published var user : User? = nil
    @Published var famille : Famille? = nil
    
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
    let name : String
    let logo : String
    var score : Int 
}

extension Famille {
    static let famillesExemple : [Famille] = [
        Famille(name: "Carivederci", logo: "CVD", score: 2024),
        Famille(name: "Dream Team", logo: "DRT", score: 1024),
        Famille(name: "Les Mineurs du Fond", logo: "MDF", score: 867),
        Famille(name: "Caripotter", logo: "CPT", score: 624),
        Famille(name: "Autre team", logo: "RDM", score: 444),
        Famille(name: "Les Fet'arts", logo: "ART", score: 367),
        Famille(name: "Les Petits", logo: "PTT", score: 244),
    ]
}

struct Sponsor  {
    let imageName : String
    let marqueName : String
}

extension Sponsor {
    static let listeSponsor : [Sponsor] = [
        Sponsor(imageName: "Osakatoys", marqueName: "Osakatoys"),
        Sponsor(imageName: "Briques Rouges", marqueName: "Festival les briques rouges"),
        Sponsor(imageName: "Leon", marqueName: "Léon de Bruxelles"),
        Sponsor(imageName: "Murder", marqueName: "France Murder"),
        Sponsor(imageName: "Pixelbar", marqueName: "Pixelbar"),
        Sponsor(imageName: "Reload", marqueName: "Reload"),
        Sponsor(imageName: "Via Ristorante", marqueName: "Via Ristorante"),
        Sponsor(imageName: "VNB", marqueName: "V&B"),
        Sponsor(imageName: "le HI", marqueName: "Le Hi"),
        Sponsor(imageName: "Les 3 brasseurs", marqueName: "Les 3 Brasseurs"),
        Sponsor(imageName: "Reve d'O", marqueName: "Le RÊVE D'Ô"),
    ]
}

struct Message : Codable {
    let message : String
}

struct Score : Codable {
    let score : Int
}

struct QrCode : Codable {
    let qrToken : String
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
    let user : [UserResponse]
    let token : String
}

struct UserResponse : Codable {
    let username : String
    let score : Int
    let role : Int
}
func ResponseToApp(res : UserResponse) -> User?{
    return User(pseudo: res.username, score: res.score, isAdmin: res.role == 1)
}

struct FamilleList : Codable {
    let famille : [Famille]
}

struct PasswordChange :Codable {
    let password :String
    let newPassword : String
    let repeatNewPassword : String
}
