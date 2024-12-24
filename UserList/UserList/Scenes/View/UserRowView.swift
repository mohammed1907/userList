//
//  UserRowView.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

import SwiftUI

struct UserRowView: View {
    let user: UserListModelElement
    let isLiked: Bool
    let onLikeToggle: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name ?? "")
                    .font(.headline)
                Text(user.email ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                if let companyName = user.company?.name {
                    Text(companyName)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Button(action: onLikeToggle) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundColor(isLiked ? .red : .gray)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(
            user: UserListModelElement(
                id: 1,
                name: "Mohamed Farghaly",
                username: "Farghaly",
                email: "farghaly@gmail.com",
                address: nil,
                phone: "1091997895",
                website: nil,
                company: Company(name: "company", catchPhrase: nil, bs: nil)
            ),
            isLiked: false,
            onLikeToggle: {}
        )
        .previewLayout(.sizeThatFits)
    }
}
