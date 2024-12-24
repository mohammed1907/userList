//
//  UserListViewModel.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

import Foundation
import Combine

protocol UserListViewModelProtocol: ObservableObject {
    var users: UserListModel { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func fetchUsers()
}

class UserListViewModel: UserListViewModelProtocol {
    //MARK: Proberities
    @Published var users: UserListModel = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let userListService: UserListService
    private var cancellables = Set<AnyCancellable>()

    init(userListService: UserListService = UserListServiceImplement()) {
        self.userListService = userListService
    }
   //MARK: Network call
    func fetchUsers() {
        isLoading = true
        errorMessage = nil
        userListService.getUsersList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                case .finished:
                    break
                }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
}