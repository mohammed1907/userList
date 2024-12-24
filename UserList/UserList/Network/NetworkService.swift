//
//  NetworkService.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

import Combine
import Alamofire
import Reachability
import SwiftUI

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ route: NetworkRouter) -> AnyPublisher<T, AFError>
    func isNetworkReachable() -> Bool
}
class NetworkService: NetworkServiceProtocol {
    private let session: Session
    private let reachability = try! Reachability()
    private var pendingRequests: [() -> Void] = []

    init() {
        let configuration = URLSessionConfiguration.af.default
        let networkLogger = NetworkLogger()

        session = Session(
            configuration: configuration,
            eventMonitors: [networkLogger]
        )
        startReachabilityNotifier()
    }

    // MARK: - Reachability
    private func startReachabilityNotifier() {
        reachability.whenReachable = { [weak self] _ in
            self?.retryPendingRequests()
        }
        reachability.whenUnreachable = { _ in
            print("Network not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }

    private func retryPendingRequests() {
        for request in pendingRequests {
            request()
        }
        pendingRequests.removeAll()
    }

    private func addPendingRequest(_ request: @escaping () -> Void) {
        pendingRequests.append(request)
    }

    func isNetworkReachable() -> Bool {
        return reachability.connection != .unavailable
    }

    // MARK: - Request Method
    func request<T: Decodable>(_ route: NetworkRouter) -> AnyPublisher<T, AFError> {
        guard isNetworkReachable() else {
            return Future { [weak self] promise in
                self?.addPendingRequest {
                    _ = self?.request(route).sink(receiveCompletion: { (completion: Subscribers.Completion<AFError>) in
                    }, receiveValue: { (value: T) in
                    })
                }
                promise(.failure(AFError.sessionTaskFailed(error: URLError(.notConnectedToInternet))))
            }
            .eraseToAnyPublisher()
        }

        return session.request(route)
            .validate()
            .publishDecodable(type: T.self)
            .value()
            .eraseToAnyPublisher()
    }
}
