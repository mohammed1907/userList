//
//  UserListService.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

import Combine
import Alamofire

protocol UserListService {
    func getUsersList() -> AnyPublisher<UserListModel, AFError>
}

class UserListServiceImplement: UserListService {
    private let networkService: NetworkServiceProtocol
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    func getUsersList() -> AnyPublisher<UserListModel, AFError> {
        networkService.request(.getUsersList)
    }
}
