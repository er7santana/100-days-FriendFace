//
//  UsersViewModel.swift
//  FriendFace
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 03/08/24.
//

import Foundation

class UsersViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    func fetchUsers() async {
        
        if users.isEmpty == false { return }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Application/JSON", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        do {
            let (result, _) = try await URLSession.shared.data(for: urlRequest)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let items = try decoder.decode([User].self, from: result)
            await MainActor.run {
                users = items
            }
        } catch {
            print("Failed to fetchData from server:  \(error.localizedDescription)")
            await MainActor.run {
                users = [
                    User.mockItem
                ]
            }
        }
    }
}
