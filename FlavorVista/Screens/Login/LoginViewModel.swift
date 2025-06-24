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
    var emailError: String? = nil

    var password = ""
    var passwordError: String? = nil

    var isSigningIn = false

    func signIn() {
        isSigningIn = true
        emailError = nil
        passwordError = nil

        Task {
            defer { isSigningIn = false }

            if email.isEmpty {
                emailError = "Please enter your email"
                return
            } else if !isValidEmail(email) {
                emailError = "Invalid email format"
                return
            }

            if password.isEmpty {
                passwordError = "Please enter your password"
                return
            } else if password.count < 6 {
                passwordError = "Password must be at least 6 characters"
                return
            }

            do {
                try await AuthService.shared.signIn(email: email, password: password)
            } catch {
                print("Login error: \(error.localizedDescription)")
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}
