//
//  UserListModel.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

import Foundation

// MARK: - UserListModelElement
struct UserListModelElement: Codable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
    let phone, website: String?
    let company: Company?
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String?
}

typealias UserListModel = [UserListModelElement]
