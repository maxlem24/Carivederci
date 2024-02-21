//
//  TestAPI.swift
//  Carivederci
//
//  Created by Maxime on 18/02/2024.
//


import Foundation
import SwiftUI

struct TestAPI {
    let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
    @State var users : [UserTest]?
    @State var text : String?
    init() {
        self.fetch()
    }
    func fetch() -> Void {
        URLSession.shared.fetchData(for: url) { [self] result in
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                print("Error : \(error)")
                self.text = "Error : \(error)"
            }
            
        }
    }
}
