//
//  User.swift
//  Carivederci
//
//  Created by Maxime on 07/01/2024.
//

import SwiftUI

struct User {
    let id = UUID()
    let pseudo : String
    var score = 0
    let profil : Image
    var famille : Famille
}

struct Famille {
    let id = UUID()
    let nom : String
    var membres : [User]
    var score = 0
    let profil : Image
}
