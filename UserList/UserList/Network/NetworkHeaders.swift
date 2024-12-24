//
//  NetworkHeaders.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

struct NetworkDefaults {
    var headersWithJsonEncode: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    static var `defaults` : NetworkDefaults {
      let instance = NetworkDefaults()
        return instance
    }
}
