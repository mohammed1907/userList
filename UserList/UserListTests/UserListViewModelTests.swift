//
//  UserListViewModelTests.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

import XCTest
import Combine
@testable import UserList

class UserListViewModelTests: XCTestCase {
    var viewModel: UserListViewModel!
    var mockService: MockUserListService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockUserListService()
        viewModel = UserListViewModel(userListService: mockService)
        cancellables = []
    }

    override func tearDown() {
        mockService = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        mockService.returnError = false
        let expectation = XCTestExpectation(description: "Fetching success")
        viewModel.$users
            .dropFirst()
            .sink { users in
                XCTAssertFalse(users.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchUsers()

        wait(for: [expectation], timeout: 2.0)
    }


    func testFetchUsersFailure() {
        mockService.returnError = true
        let expectation = XCTestExpectation(description: "Fetch users failure")
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                if let errorMessage = errorMessage {
                    XCTAssertNotNil(errorMessage)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchUsers()

        wait(for: [expectation], timeout: 2.0)
    }
}
