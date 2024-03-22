//
//  TestAPI.swift
//  Carivederci
//
//  Created by Maxime on 18/02/2024.
//


import Foundation
import SwiftUI

struct Post : Codable {
    let userId : Int
    let id : Int
    let title : String
    let body : String
}

func fetchData(for url: URL) -> Post? {
    var fetchedData : Post?
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data=data else {
            return
        }
        
        do {
            let posts = try JSONDecoder().decode(Post.self, from: data)
            DispatchQueue.main.async {
                fetchedData = posts
            }
        }catch {
            print(error.localizedDescription)
        }
    }.resume()
    return fetchedData
}

var post : Post? = fetchData(for: URL(fileURLWithPath: "https://jsonplaceholder.typicode.com/posts?id=1"))
