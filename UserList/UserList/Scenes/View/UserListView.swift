//
//  ContentView.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

import SwiftUI

struct UserListView<ViewModel: UserListViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(viewModel.users, id: \.id) { user in
                                UserRowView(
                                    user: user,
                                    isLiked: viewModel.isUserLiked(user: user)
                                ) {
                                    viewModel.toggleLike(user: user)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Users")
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(viewModel: MockUserListViewModel())
        //can change it to UserListViewModel() for real data
    }
}
