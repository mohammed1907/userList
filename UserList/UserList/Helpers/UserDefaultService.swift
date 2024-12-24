//
//  UserDefaultService.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//
import Foundation

class UserDefaultsService {
    private static let likedUsersKey = "likedUsers"

    static let shared = UserDefaultsService()

    private init() {}

    func getLikedUsers() -> [Int] {
        return UserDefaults.standard.array(forKey: Self.likedUsersKey) as? [Int] ?? []
    }

    func saveLikedUser(id: Int) {
        var likedUsers = getLikedUsers()
        if !likedUsers.contains(id) {
            likedUsers.append(id)
            UserDefaults.standard.setValue(likedUsers, forKey: Self.likedUsersKey)
        }
    }

    func removeLikedUser(id: Int) {
        var likedUsers = getLikedUsers()
        likedUsers.removeAll { $0 == id }
        UserDefaults.standard.setValue(likedUsers, forKey: Self.likedUsersKey)
    }

    func isUserLiked(id: Int) -> Bool {
        return getLikedUsers().contains(id)
    }
}
