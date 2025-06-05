//
//  SignInWithAppleButtonView.swift
//  FlavorVista
//
//  Created by Abdulkarim Koshak on 5/20/25.
//  © 2025 Macromin Solutions Pvt. Ltd. All rights reserved.
//
//  Description:
//  A reusable button view styled for Apple sign-in.
//  Designed to integrate visually with the FlavorVista design system.
//

import SwiftUI

/// A SwiftUI view that renders a "Continue with Apple" sign-in button,
/// styled according to the FlavorVista design system.
struct SignInWithAppleButtonView: View {
    var body: some View {
        HStack(spacing: 12) {
            // Apple icon image asset
            Image(.appleIcon)
            
            // Button label text
            Text("Continue with Apple")
                .font(.flavorVista(fontStyle: .body))
                .foregroundStyle(.grayscale100)
        }
        .frame(maxWidth: .infinity) // Full width
        .frame(height: 50) // Standard height
        .background(Color.grayscale400, in: .rect(cornerRadius: 12)) // Rounded background styling
    }
}

#Preview {
    ZStack {
        Color.grayscale600.ignoresSafeArea()
        
        // Preview with pressable interaction using custom asButton modifier
        SignInWithAppleButtonView()
            .asButton(.press) {
                // Action goes here (currently empty)
            }
    }
}
