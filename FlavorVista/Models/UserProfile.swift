//
//  UserProfile.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 19/05/24.
//

import Foundation
import SwiftData

@Model
class UserProfile: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    var name: String
    var email: String
    var age: Int
    var goalWeight: Int
    var currentWeight: Int
    var gender: String
    var hasDiabetes: Bool
    
    init(
        name: String,
        email: String,
        age: Int,
        goalWeight: Int,
        currentWeight: Int,
        gender: String,
        hasDiabetes: Bool
    ) {
        self.name = name
        self.email = email
        self.age = age
        self.goalWeight = goalWeight
        self.currentWeight = currentWeight
        self.gender = gender
        self.hasDiabetes = hasDiabetes
    }
}
