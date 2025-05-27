//
//  AuthService.swift
//  FlavorVista
//
//  Created by Abdulkarim Koshak on 5/22/25.
//

import Observation
import FirebaseAuth

@Observable final class AuthService {
    
    var currentUser: FirebaseAuth.User?
    
    private let auth = Auth.auth()
    
    static let shared = AuthService()
    
    private init() {
        currentUser = auth.currentUser
    }
    
    func signUp(email: String, password: String) async throws {
        let result = try await auth.createUser(withEmail: email, password: password)
        currentUser = result.user
        print("User created: \(result.user.email ?? "")")
    }
    
    func signIn(email: String, password: String) async throws {
        let result = try await auth.signIn(withEmail: email, password: password)
        currentUser = result.user
        print("Logged in: \(result.user.email ?? "")")
    }
    
    func signOut() throws {
        try auth.signOut()
        currentUser = nil
    }
}
