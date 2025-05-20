//
//  View+EXT.swift
//  FlavorVista
//
//  Created by Abdulkarim Koshak on 5/20/25.
//  © 2025 Macromin Solutions Pvt. Ltd. All rights reserved.
//
//  Description:
//  Adds reusable UI modifiers to SwiftUI `View` for buttons and placeholder behavior.
//  - `callToActionButton()`: Styles a view as a primary call-to-action button.
//  - `placeholder()`: Overlays a placeholder view when a condition is met (e.g., empty input).
//

import SwiftUI

extension View {
    
    /// Styles the view to appear as a primary call-to-action button.
    ///
    /// - Returns: A view with consistent CTA styling (font, color, size, background).
    func callToActionButton() -> some View {
        self
            .font(.flavorVista(fontStyle: .caption)) // Uses app-specific font style
            .foregroundStyle(.grayscale100) // Light foreground color
            .frame(maxWidth: .infinity) // Full width
            .frame(height: 50) // Fixed height
            .background(Color.primary100, in: .rect(cornerRadius: 12)) // Rounded background with primary color
    }
    
    /// Conditionally overlays a placeholder view (like in a text field).
    ///
    /// - Parameters:
    ///   - shouldShow: Boolean flag to toggle the placeholder's visibility.
    ///   - alignment: Where the placeholder appears within the parent (default: leading).
    ///   - placeholder: The view builder for your custom placeholder.
    /// - Returns: A view that conditionally displays the placeholder behind the main content.
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder()
                .opacity(shouldShow ? 1 : 0) // Show only when the condition is true
            self // Main content overlaid above
        }
    }
}
