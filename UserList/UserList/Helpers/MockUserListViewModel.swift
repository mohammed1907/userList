//
//  MockUserListViewModel.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//
import Foundation
import Combine
class MockUserListViewModel: UserListViewModelProtocol {
    @Published var users: UserListModel = [
        UserListModelElement(
            id: 1,
            name: "farghaly",
            username: "farghaly",
            email: "farghaly@gmail.com",
            address: nil,
            phone: "1091997895",
            website: nil,
            company: nil
        )
    ]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    func fetchUsers() {}
    func toggleLike(user: UserListModelElement) {}
    func isUserLiked(user: UserListModelElement) -> Bool { return true }
}
