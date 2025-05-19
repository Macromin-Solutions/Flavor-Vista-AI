//
//  ProfileViewModel.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 19/05/24.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class ProfileViewModel: ObservableObject {
    
    @Published var userProfile: UserProfile
    @Published var ageString: String = ""
    
    let genders = ["Male", "Female", "Other"]
    let modelContext: ModelContext = SwiftDataManager.shared.modelContainer.mainContext
    
    init() {
        // Initialize with default values
        self.userProfile = UserProfile(name: "User", email: "user@example.com", age: 30, gender: "Male", hasDiabetes: false)
        loadProfile()
    }
    
    func loadProfile() {
        let fetchDescriptor = FetchDescriptor<UserProfile>()
        do {
            if let profile = try modelContext.fetch(fetchDescriptor).first {
                self.userProfile = profile
                self.ageString = String(profile.age)
            }
        } catch {
            print("Failed to fetch profile: \(error)")
        }
    }
    
    func saveProfile() {
        guard let age = Int(ageString) else {
            // Show an alert that the age value is invalid
            return
        }
        userProfile.age = age
        do {
            modelContext.insert(userProfile)
            try modelContext.save()
        } catch {
            print("Failed to save profile: \(error)")
        }
    }
}
