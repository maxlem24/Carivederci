//
//  Data.swift
//  Carivederci
//
//  Created by Maxime on 18/02/2024.
//
import Foundation
import SwiftUI


/*
guard let url = URL(string : hostName+"/scan-qrcode")else {
    errorText = "Une erreur est survenue, veuillez réessayer"
    return
}
guard let token = Auth.shared.getAccessToken() else {
    errorText = "Une erreur est survenue, veuillez réessayer"
    return
}
do{
    
    var request = URLRequest(url : url)
    request.setValue(token, forHTTPHeaderField: "authorization")
    let (data,response) = try await URLSession.shared.data(for : request)
    let httpResponse = response as? HTTPURLResponse
    if httpResponse?.statusCode == 201 {
        if let decodedResponse = try? JSONDecoder().decode(Message.self, from: data) {
            print(decodedResponse.message)
        }
    }else {
        if let decodedError = try? JSONDecoder().decode(Message.self, from: data) {
            errorText = decodedError.message
        }            }
} catch {
    errorText = "Une erreur est survenue, veuillez réessayer"
}

enum DataError : Error {
    case URLError,ResponseError,DecodeError
}
*/

