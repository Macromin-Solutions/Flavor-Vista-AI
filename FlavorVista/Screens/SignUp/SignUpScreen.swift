//
//  SignUpScreen.swift
//  FlavorVista
//
//  Created by Ahmad Dannah on 22/11/1446 AH.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel = SignUpViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    HeaderSection(title: "Create FlavorVista Account",
                                  subtitle: "Eat better. Get back on track.")

                    
                    VStack(alignment: .leading, spacing: 20) {
                        FVTextFieldView(text: $viewModel.fullName)
                            .setTitleText("Full Name")
                            .setPlaceholderText("Enter Full Name")
                        
                        FVTextFieldView(text: $viewModel.email)
                            .setTitleText("Email")
                            .setPlaceholderText("Enter Email")
                            .setKeyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                        
                        FVTextFieldView(text: $viewModel.password)
                            .setTitleText("Password")
                            .setPlaceholderText("Enter Password")
                            .setSecureText(true)
                            .textInputAutocapitalization(.never)

                        FVTextFieldView(text: $viewModel.confirmPassword)
                            .setTitleText("Confirm Password")
                            .setPlaceholderText("Re Enter Password")
                            .setSecureText(true)
                            .textInputAutocapitalization(.never)

                    }
                    .padding(.vertical, 48)
                    
                    Spacer()
                    
                    VStack(spacing: 24) {
                        AsyncCallToActionButton(
                            isLoading: viewModel.isSigningUp,
                            title: "Sign Up",
                            action: viewModel.signUp
                        )
                        
                        HStack {
                            Text("Already have an account?")
                                .foregroundStyle(.grayscale100)
                            
                            Text("Log In")
                                .foregroundStyle(.primary100)
                                .asButton {
                                    dismiss()
                                }
                        }
                        .font(.flavorVista(fontStyle: .body))
                    }
                }
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.grayscale600)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        print("Clicked on Back")
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary100)
                    }
                }
            }
        }
    }
}

#Preview {
    SignUpScreen()
}
