//
//  SignUpViewModel.swift
//  FlavorVista
//
//  Created by Ahmad Dannah on 22/11/1446 AH.
//

import FirebaseAuth
import SwiftUICore

@MainActor
class SignUpViewModel: ObservableObject {
    
    
    func signUp(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email and Password must not be empty.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
            } else {
                print("User created: \(result?.user.email ?? "")")
                // Navigate to the next Screen
            }
        }
    }
    
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
            } else {
                print("Logged in: \(result?.user.email ?? "")")
            }
        }
    }
}
