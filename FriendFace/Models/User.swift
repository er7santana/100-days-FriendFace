//
//  User.swift
//  FriendFace
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 03/08/24.
//

import Foundation

struct User: Codable, Hashable, Identifiable {
    
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    static var mockItem: User {
        User(
            id: UUID().uuidString,
            isActive: true,
            name: "Eliezer Sant Ana",
            age: 36,
            company: "Santander",
            email: "eliezer@santander.com",
            address: "Rua da Felicidade, 337 - Mauá - SP - Brasil",
            about: "Software developer and Santos fan",
            registered: Date.now,
            tags: ["Swift", "SwiftUI", "F1", "Santos"],
            friends: [
                Friend(id: UUID().uuidString,
                       name: "Roberta Sant Ana"),
                Friend(id: UUID().uuidString,
                       name: "Rosa Maria"),
            ]
        )
    }
}
