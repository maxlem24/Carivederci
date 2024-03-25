//
//  Rules.swift
//  Carivederci
//
//  Created by Maxime on 12/03/2024.
//

import SwiftUI
import SwiftKeychainWrapper


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

class Auth : ObservableObject {
    
    struct Credentials {
        var accessToken : String?
        var refreshToken : String?
    }
    
    enum KeychainKey : String {
        case accessToken
        case refreshToken
    }
    
    static let shared: Auth = Auth()
    private let keychain : KeychainWrapper = KeychainWrapper.standard
    
    @Published var loggedIn : Bool = false
    
    private init() {
        loggedIn = hasAccessToken()
    }
    
    func getCredentials() -> Credentials {
        return Credentials(
            accessToken: keychain.string(forKey: KeychainKey.accessToken.rawValue),
            refreshToken: keychain.string(forKey: KeychainKey.refreshToken.rawValue))
    }
    
    func setCredentials(accessToken : String, refreshToken : String) {
        keychain.set(accessToken, forKey : KeychainKey.accessToken.rawValue)
        keychain.set(refreshToken, forKey : KeychainKey.refreshToken.rawValue)
        
        loggedIn = true
    }
    
    func hasAccessToken() -> Bool {
        return getCredentials().accessToken != nil
    }
    
    func getAccessToken() -> String? {
        return getCredentials().accessToken
    }
    
    func getRefreshToken() -> String? {
        return getCredentials().refreshToken
    }
    
    func logout(){
        KeychainWrapper.standard.removeObject(forKey : KeychainKey.accessToken.rawValue)
        KeychainWrapper.standard.removeObject(forKey : KeychainKey.refreshToken.rawValue)
        
        loggedIn = false
    }
}
