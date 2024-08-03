//
//  ContentView.swift
//  FriendFace
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 03/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = UsersViewModel()
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(viewModel.users) { user in
                    NavigationLink(value: user) {
                        LazyHStack {
                            Circle()
                                .foregroundStyle(user.isActive ? .green : .red)
                                .padding([.vertical, .trailing])
                            Text(user.name)
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
}

#Preview {
    ContentView()
}
