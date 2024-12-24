//
//  Config.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

import Foundation

struct Config {
    static let baseURL: String = "https://jsonplaceholder.typicode.com/"
    struct EndpointPath {
        static let getUsers = "users"
        
    }
}
enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}
let kDefaults = UserDefaults.standard
