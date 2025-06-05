//
//  SignUpViewModel.swift
//  FlavorVista
//
//  Created by Ahmad Dannah on 22/11/1446 AH.
//

import SwiftUI
import Observation

@Observable class SignUpViewModel {
    var fullName = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    var isSigningUp = false
    
    func signUp() {
        isSigningUp = true
        
        Task {
            do {
                if email.isEmpty || password.isEmpty {
                    isSigningUp = false
                    print("Email and Password must not be empty.")
                    return
                }
                
                if confirmPassword != password {
                    isSigningUp = false
                    print("Password not match")
                    return
                }
                
                try await AuthService.shared.signUp(email: email, password: password)
                isSigningUp = false
            } catch {
                print("Error creating user: \(error.localizedDescription)")
            }
        }
    }
}
