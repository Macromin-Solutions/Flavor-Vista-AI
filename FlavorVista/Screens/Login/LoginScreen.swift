//
//  LoginScreen.swift
//  FlavorVista
//
//  Created by Abdulkarim Koshak on 5/19/25.
//  © 2025 Macromin Solutions Pvt. Ltd. All rights reserved.
//

import SwiftUI

/// Represents the login screen for the FlavorVista app.
struct LoginScreen: View {
    // MARK: - State Properties
    
    @State private var viewModel = LoginViewModel()
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // MARK: - Title Section
                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome Back to FlavorVista")
                        .font(.flavorVista(fontStyle: .title2))
                        .foregroundStyle(.grayscale100)
                    
                    Text("Eat better. Get back on track.")
                        .font(.flavorVista(fontStyle: .body))
                        .foregroundStyle(.grayscale100)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                // MARK: - Input Fields & Forgot Password
                VStack(spacing: 32) {
                    VStack(spacing: 12) {
                        VStack(spacing: 20) {
                            // Email Input
                            FVTextFieldView(text: $viewModel.email)
                                .setTitleText("Email")
                                .setPlaceholderText("Enter Email")
                                .setKeyboardType(.emailAddress)
                                .setError(errorText: Binding(
                                            get: { viewModel.emailError ?? "" },
                                            set: { _ in }), error: .constant(viewModel.emailError != nil)
                                        )
                                .textInputAutocapitalization(.never)
                            
                            // Password Input
                            FVTextFieldView(text: $viewModel.password)
                                .setTitleText("Password")
                                .setPlaceholderText("Enter Password")
                                .setSecureText(true)
                                .setError(errorText: Binding(
                                    get: { viewModel.passwordError ?? "" },
                                    set: { _ in }), error: .constant(viewModel.passwordError != nil)
                                        )
                        }
                        
                        // Forgot Password Link
                        Text("Forgot Password?")
                            .font(.flavorVista(fontStyle: .body))
                            .foregroundStyle(.grayscale100)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    // MARK: - OR Divider
                    HStack(spacing: 12) {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .foregroundStyle(.grayscale400)
                        
                        Text("Or")
                            .font(.flavorVista(fontStyle: .footnote))
                            .foregroundStyle(.grayscale100)
                        
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .foregroundStyle(.grayscale400)
                    }
                    
                    // MARK: - Alternative Sign-In Options
                    VStack(spacing: 20) {
                        SignInWithGoogleButtonView()
                        
                        SignInWithAppleButtonView()
                    }
                }
                
                Spacer()
                
                // MARK: - Log In Button and Sign-Up Prompt
                VStack(spacing: 24) {
                    AsyncCallToActionButton(
                        isLoading: viewModel.isSigningIn,
                        title: "Log In",
                        action: viewModel.signIn
                    )
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(.grayscale100)
                        
                        NavigationLink {
                            SignUpScreen()
                                .navigationBarBackButtonHidden()
                        } label: {
                            Text("Sign Up")
                                .foregroundStyle(.primary100)
                        }
                    }
                    .font(.flavorVista(fontStyle: .body))
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.grayscale600)
        }
    }
}

#Preview {
    LoginScreen()
}
