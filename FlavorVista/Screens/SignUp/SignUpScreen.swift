//
//  SignUpScreen.swift
//  FlavorVista
//
//  Created by Ahmad Dannah on 22/11/1446 AH.
//

import SwiftUI

struct SignUpScreen: View {
    
    @StateObject private var viewModel = SignUpViewModel()

    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    HeaderSection(title: "Create FlavorVista Account",
                                  subtitle: "Eat better. Get back on track.")

                    
                    VStack(alignment: .leading, spacing: 20) {
                        FVTextFieldView(text: $fullName)
                            .setTitleText("Full Name")
                            .setPlaceholderText("Enter Full Name")
                        
                        FVTextFieldView(text: $email)
                            .setTitleText("Email")
                            .setPlaceholderText("Enter Email")
                        
                        FVTextFieldView(text: $password)
                            .setTitleText("Password")
                            .setPlaceholderText("Enter Password")
                            .setSecureText(true)

                        FVTextFieldView(text: $confirmPassword)
                            .setTitleText("Confirm Password")
                            .setPlaceholderText("Re Enter Password")
                            .setSecureText(true)

                    }
                    .padding(.vertical, 48)
                    
                    Spacer()
                    VStack(spacing: 24) {
                        Button {
                            print("Clicked on Sign Up")
                            if password == confirmPassword {
                                viewModel.signUp(email: email,
                                                 password: password)
                            } else {
                                print("Password not match")
                            }
                        } label: {
                            Text("Sign Up")
                                .callToActionButton()
                        }
                        
                        HStack {
                            Text("Already have an account?")
                                .foregroundStyle(.grayscale100)
                            Button {
                                print("Clicked on Log In")
                            } label: {
                                Text("Log In")
                                    .foregroundStyle(.primary100)
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
