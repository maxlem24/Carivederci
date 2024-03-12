//
//  Rules.swift
//  Carivederci
//
//  Created by Maxime on 12/03/2024.
//
import SwiftUI


func isValidPseudo(_ pseudo : String) -> Bool {
    let pseudoRegEx = "[A-Za-z0-9]{6,}"
    let pseudoPred = NSPredicate(format: "SELF MATCHES %@",pseudoRegEx)
    return pseudoPred.evaluate(with: pseudo)
}

func isValidPrenom(_ prenom : String) -> Bool {
    let prenomRegEx = "[A-Za-z]{2,}"
    let prenomPred = NSPredicate(format: "SELF MATCHES %@",prenomRegEx)
    return prenomPred.evaluate(with: prenom)
}

func isValidNom(_ nom : String) -> Bool {
    let nomRegEx = "[A-Za-z]{2,}"
    let nomPred = NSPredicate(format: "SELF MATCHES %@",nomRegEx)
    return nomPred.evaluate(with: nom)
}

func isValidMail(_ email : String) -> Bool {
    let emailRegEx = "[A-Za-z0-9._%+-]{2,64}@[A-Za-z0-9-]{1,62}\\.[A-Za-z]{2,3}"
    let emailPred = NSPredicate(format: "SELF MATCHES %@",emailRegEx)
    return emailPred.evaluate(with: email)
}

func isValidPassword(_ password : String) -> Bool {
    let passwordRegEx = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[=@#\\$%\\^&\\*()\\-_+\\.]){8,}"
    let passwordPred = NSPredicate(format: "SELF MATCHES %@",passwordRegEx)
    return passwordPred.evaluate(with: password)
}
