//
//  UserModel.swift
//  FlavorVista
//
//  Created by Abdulkarim Koshak on 5/22/25.
//

import Foundation

struct UserModel: Codable {
    let userId: String
    let fullName: String?
    let email: String?
    
    init(
        userId: String,
        fullName: String? = nil,
        email: String? = nil
    ) {
        self.userId = userId
        self.fullName = fullName
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case fullName = "full_name"
        case email
    }
    
    static var mock: Self {
        UserModel(
            userId: UUID().uuidString,
            fullName: "Jane Cooper",
            email: "janecooper@email.com"
        )
    }
}
