//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 03/08/24.
//

import SwiftUI

struct UserDetailView: View {
    
    let user: User
    
    var body: some View {
        Form {
            Section("Basic data") {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(user.name)
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text("Age")
                    Spacer()
                    Text(user.age.formatted())
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text("Company")
                    Spacer()
                    Text(user.company)
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text("Email")
                    Spacer()
                    Text(user.email)
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text("Registered")
                    Spacer()
                    Text(user.registered.formatted(date: .abbreviated, time: .shortened))
                        .foregroundStyle(.secondary)
                }
            }
            Section("Address") {
                Text(user.address)
                    .foregroundStyle(.secondary)
            }
            Section("About") {
                Text(user.about)
            }
            Section("Tags") {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            }
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        UserDetailView(user: User.mockItem)
    }
}
