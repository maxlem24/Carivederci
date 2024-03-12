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
    static func == (left : User, right : User)-> Bool{
        return left.id == right.id && left.pseudo == right.pseudo && left.score == right.score && left.profil == right.profil
    }
    
}

class AppUser : ObservableObject {
    @Published var user : User?
}

struct Famille : Codable{
    let id : String
    let nom : String
    var score : Int
    let profil : String
}

struct FamilleList : Codable {
    let familles : [Famille]
    func getIndex(index : Int) -> Famille?{
        if index >= familles.count {
            return nil
        }else {
            return familles[index]
        }
    }
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
