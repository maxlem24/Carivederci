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
    func setUser(user : User) {
        self.user = user
    }
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
