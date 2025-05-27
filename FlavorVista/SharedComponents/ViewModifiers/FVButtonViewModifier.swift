//
//  FVButtonViewModifier.swift
//  FlavorVista
//
//  Created by Abdulkarim Koshak on 5/20/25.
//  © 2025 Macromin Solutions Pvt. Ltd. All rights reserved.
//
//  Description:
//  This file defines a custom `ButtonStyle` and a `View` extension that enables any SwiftUI view to behave as a tappable button.
//  It supports both a pressable animation style and a plain style for UI flexibility.
//

import SwiftUI

/// A custom button style that applies a scale effect when the button is pressed, giving a tactile "press" feedback.
struct PressableButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1) // Shrinks slightly when pressed
            .animation(.smooth, value: configuration.isPressed) // Smooth animation between states
    }
}

/// Defines the two supported button styles for views acting as buttons.
enum ButtonStyleOption {
    case press // Applies the PressableButtonStyle
    case plain // Uses the default PlainButtonStyle
}

extension View {
    
    /// Transforms any view into a tappable button with the specified style and action.
    ///
    /// - Parameters:
    ///   - option: The button style to apply (`.press` or `.plain`). Defaults to `.plain`.
    ///   - action: The closure to execute when the button is tapped.
    /// - Returns: A view that behaves like a button.
    @ViewBuilder
    func asButton(_ option: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
        switch option {
        case .press:
            self.pressableButton(action: action)
        case .plain:
            self.plainButton(action: action)
        }
    }
    
    /// Wraps the view in a standard SwiftUI `Button` using the `PlainButtonStyle`.
    private func plainButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    /// Wraps the view in a SwiftUI `Button` using the custom `PressableButtonStyle`.
    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PressableButtonStyle())
    }
}

#Preview {
    ZStack {
        Color.grayscale600.ignoresSafeArea()
        
        VStack(spacing: 32) {
            // Example button using the pressable style
            Text("Log In")
                .callToActionButton()
                .asButton(.press) {
                    
                }
            
            // Example button using the plain style
            Text("Sign Up")
                .font(.flavorVista(fontStyle: .body))
                .foregroundStyle(.primary100)
                .asButton {
                    
                }
        }
    }
}
