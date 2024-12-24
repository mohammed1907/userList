//
//  MockUserListService.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

@testable import UserList
import Combine
import Alamofire
class MockUserListService: UserListService {
    var returnError = false

    func getUsersList() -> AnyPublisher<UserListModel, AFError> {
        if returnError {
            return Fail(error: AFError.explicitlyCancelled)
                .eraseToAnyPublisher()
        }

        let mockData: UserListModel = [
            UserListModelElement(
                id: 1,
                name: "farghaly",
                username: "testfarghaly",
                email: "farghaly@example.com",
                address: Address(
                    street: "street12",
                    suite: "Suite123",
                    city: "cairo",
                    zipcode: "777777",
                    geo: Geo(lat: "30.0", lng: "29.0")
                ),
                phone: "1091997895",
                website: "test.com",
                company: Company(
                    name: "company",
                    catchPhrase: "test",
                    bs: "Test BS"
                )
            )
        ]

        return Just(mockData)
            .setFailureType(to: AFError.self)
            .eraseToAnyPublisher()
    }
}
