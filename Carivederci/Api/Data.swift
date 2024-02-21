//
//  Data.swift
//  Carivederci
//
//  Created by Maxime on 18/02/2024.
//
import Foundation
import SwiftUI

extension URLSession {
    func fetchData(for url: URL, onCompletion : @escaping ([Famille]) -> ())  {
    self.dataTask(with: url) { (data, response, error) in
        guard let data=data else {
            return
        }

        guard let list = try? JSONDecoder().decode(FamilleList.self, from: data) else {
            return
        }
        onCompletion(list.familles)
    }.resume()
  }
}

func getFamilles()  throws -> FamilleList {
    
    guard let url = URL(string: "url") else {
        throw DataError.URLError
    }
    
    let (data,response) = try URLSession.shared.data(from: url) // await
    
    guard let responsecpy = response as? HTTPURLResponse, responsecpy.statusCode == 200 else {
        throw DataError.ResponseError
    }
    
    do {
        return try JSONDecoder().decode(FamilleList.self, from: data)
    }catch {
        throw DataError.DecodeError
    }
}

enum DataError : Error {
    case URLError,ResponseError,DecodeError
}

