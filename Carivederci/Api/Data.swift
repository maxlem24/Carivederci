//
//  Data.swift
//  Carivederci
//
//  Created by Maxime on 18/02/2024.
//
import Foundation
import SwiftUI

extension User{
    static func fetchData(for url: URL?) -> User? {
        guard let url=url else {
            return nil
        }
        var fetchedData : User?
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data=data else {
                return
            }
            
            guard let list = try? JSONDecoder().decode([Famille].self, from: data) else {
                return
            }
            onCompletion(list)
        }.resume()
        return fetchedData
    }
    static func postData(to url: URL?,user : User)  {
        guard let url=url else {
            return
        }
        do {
            let data = try JSONEncoder().encode(user)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            
            URLSession.shared.dataTask(with: request) {
                data, response, error in
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                
                if statusCode == 200 {
                    print("Success")
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
}


extension Famille{
    static func fetchData(for url: URL?) -> Famille? {
        guard let url=url else {
            return nil
        }
        var fetchedData : Famille?
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data=data else {
                return
            }
            
            do {
                let famille = try JSONDecoder().decode(Famille.self, from: data)
                DispatchQueue.main.async {
                    fetchedData = famille
                }
            }catch {
                print(error.localizedDescription)
            }
        }.resume()
        return fetchedData
    }
}


enum DataError : Error {
    case URLError,ResponseError,DecodeError
}

