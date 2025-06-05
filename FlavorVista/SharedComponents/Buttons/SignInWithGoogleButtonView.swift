//
//  SignInWithGoogleButtonView.swift
//  FlavorVista
//
//  Created by Abdulkarim Koshak on 5/20/25.
//  © 2025 Macromin Solutions Pvt. Ltd. All rights reserved.
//
//  Description:
//  A reusable button view styled for Google sign-in.
//  Used in authentication flows to provide users with an alternative login method.
//

import SwiftUI

/// A SwiftUI view that renders a "Continue with Google" sign-in button,
/// designed to match the FlavorVista app's styling system.
struct SignInWithGoogleButtonView: View {
    var body: some View {
        HStack(spacing: 12) {
            // Google icon image asset
            Image(.googleIcon)
            
            // Button label
            Text("Continue with Google")
                .font(.flavorVista(fontStyle: .body))
                .foregroundStyle(.grayscale100)
        }
        .frame(maxWidth: .infinity) // Full-width button
        .frame(height: 50) // Standard button height
        .background(Color.grayscale400, in: .rect(cornerRadius: 12)) // Background with rounded corners
    }
}

#Preview {
    ZStack {
        // Background layer for preview
        Color.grayscale600.ignoresSafeArea()
        
        // Preview with press interaction using custom .asButton() modifier
        SignInWithGoogleButtonView()
            .asButton(.press) {
                // Action callback (to be implemented)
            }
    }
}
