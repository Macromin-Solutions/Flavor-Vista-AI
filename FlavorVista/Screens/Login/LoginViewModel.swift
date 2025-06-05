//
//  LoginViewModel.swift
//  FlavorVista
//
//  Created by Abdulkarim Koshak on 5/23/25.
//

import SwiftUI
import Observation

@Observable class LoginViewModel {
    var email = ""
    var showEmailError = false
    
    var password = ""
    var showPasswordError = false
    
    var isSigningIn = false
    
    func signIn() {
        isSigningIn = true
        showEmailError = false
        showPasswordError = false
        
        Task {
            do {
                if email.isEmpty {
                    isSigningIn = false
                    showEmailError = true
                    print("Email must not be empty.")
                    return
                }
                
                if password.isEmpty {
                    isSigningIn = false
                    showPasswordError = true
                    print("Email and Password must not be empty.")
                    return
                }
                
                try await AuthService.shared.signIn(email: email, password: password)
                isSigningIn = false
            } catch {
                print("Login error: \(error.localizedDescription)")
                isSigningIn = false
            }
        }
    }
}
