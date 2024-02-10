//
//  User.swift
//  Carivederci
//
//  Created by Maxime on 07/01/2024.
//

import SwiftUI

struct User : Equatable{
    let id = UUID()
    let pseudo : String
    var score = 0
    let profil : Image
    var famille : Famille?
    static func == (left : User, right : User)-> Bool{
        return left.id == right.id && left.pseudo == right.pseudo && left.score == right.score && left.profil == right.profil
    }
    
}

struct Famille {
    let id = UUID()
    let nom : String
    var membres : [User]
    var score = 0
    let profil : Image
}
