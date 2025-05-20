//
//  FVTextFieldView.swift
//  FlavorVista
//
//  Created by Abdulkarim Koshak on 5/20/25.
//  © 2025 Macromin Solutions Pvt. Ltd. All rights reserved.
//
//  Description:
//  A reusable, customizable text field component used across the FlavorVista app.
//  Supports optional title, placeholder, secure entry, validation error display,
//  and different keyboard configurations.
//

import SwiftUI

/// A reusable text field component for user input, supporting customization such as secure text entry,
/// error handling, disabling, placeholder and title text.
struct FVTextFieldView: View {
    
    // MARK: - Configurable Properties
    
    /// The bound text value entered by the user.
    private var text: Binding<String>
    
    /// Optional flag to disable the text field.
    private var disable: Binding<Bool>?
    
    /// Optional flag to indicate a validation error.
    private var error: Binding<Bool>?
    
    /// Optional error message to display below the field.
    private var errorText: Binding<String>?
    
    /// Enables secure (password-style) text entry.
    private var isSecureText: Bool = false
    
    /// Optional title displayed above the field.
    private var titleText: String?
    
    /// Placeholder text shown when input is empty.
    private var placeholderText: String = ""
    
    /// Keyboard type (e.g. email, numberPad).
    private var keyboardType: UIKeyboardType = .default
    
    // MARK: - UI State
    
    @State private var isFocused = false
    @State private var secureText = false {
        didSet {
            if secureText {
                isFocused = false
            }
        }
    }
    
    private let cornerRadius: CGFloat = 12
    private let textFieldHeight: CGFloat = 50
    
    // MARK: - Initializer
    
    init(text: Binding<String>) {
        self.text = text
    }
    
    // MARK: - View Body
    
    var body: some View {
        VStack(spacing: 4) {
            // Optional title text
            if let titleText {
                Text(titleText)
                    .font(.flavorVista(fontStyle: .body))
                    .foregroundStyle(.grayscale100)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack(spacing: 0) {
                // TextField
                HStack(spacing: 0) {
                    secureAnyView()
                        .placeholder(when: text.wrappedValue.isEmpty) {
                            Text(placeholderText)
                                .font(.flavorVista(fontStyle: .body))
                                .foregroundStyle(.grayscale200)
                        }
                        .font(.flavorVista(fontStyle: .body))
                        .frame(maxWidth: .infinity)
                        .frame(height: textFieldHeight)
                        .foregroundStyle(.grayscale100)
                        .disabled(disable?.wrappedValue ?? false)
                        .padding(.horizontal, 20)
                        .keyboardType(keyboardType)
                        .background(Color.clear)
                }
                .background {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(getBorderColor(), lineWidth: 1)
                        .background(Color.grayscale600, in: .rect(cornerRadius: cornerRadius))
                }
            }
            
            // Optional error message
            if let error = error?.wrappedValue {
                if error {
                    Text(errorText?.wrappedValue ?? "")
                        .font(.flavorVista(fontStyle: .body))
                        .foregroundStyle(.message200)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
    
    // MARK: - Helper Views and Methods
    
    /// Chooses between a regular or secure input field depending on configuration.
    private func secureAnyView() -> AnyView {
        if !secureText {
            return AnyView(TextField("", text: text, onEditingChanged: { changed in
                if changed {
                    isFocused = true
                } else {
                    isFocused = false
                }
            }))
        } else {
            return AnyView(SecureField("", text: text))
        }
    }
    
    /// Determines the border color based on focus or error state.
    private func getBorderColor() -> Color {
        if error?.wrappedValue ?? false {
            return Color.message200
        }
        
        if isFocused {
            return Color.grayscale100
        }
        
        return Color.grayscale400
    }
}

// MARK: - Configuration Modifiers

extension FVTextFieldView {
    
    /// Sets the title text above the field.
    public func setTitleText(_ titleText: String) -> Self{
        var copy = self
        copy.titleText = titleText
        return copy
    }
    
    /// Sets the placeholder text shown when the field is empty.
    public func setPlaceholderText(_ placeHolderText: String) -> Self {
        var copy = self
        copy.placeholderText = placeHolderText
        return copy
    }
    
    /// Binds a Boolean to enable or disable the field.
    public func setDisable(_ disable: Binding<Bool>) -> Self{
        var copy = self
        copy.disable = disable
        return copy
    }
    
    /// Enables validation error display with bound error flag and message.
    public func setError(errorText: Binding<String>, error: Binding<Bool>) -> Self {
        var copy = self
        copy.error = error
        copy.errorText = errorText
        return copy
    }
    
    /// Configures the field for secure (password) input.
    public func setSecureText(_ secure: Bool) -> Self{
        var copy = self
        copy._secureText = State(initialValue: secure)
        copy.isSecureText = secure
        return copy
    }
    
    /// Sets the keyboard type for the input field.
    public func setKeyboardType(_ type: UIKeyboardType) -> Self {
        var copy = self
        copy.keyboardType = type
        return copy
    }
}

// MARK: - Previews

#Preview("Default") {
    @Previewable @State var name = ""
    
    ZStack {
        Color.grayscale600.ignoresSafeArea()
        
        FVTextFieldView(text: $name)
            .setTitleText("First name here")
            .setPlaceholderText("First name here")
            .padding(20)
    }
}

#Preview("Secure") {
    @Previewable @State var password = ""
    
    ZStack {
        Color.grayscale600.ignoresSafeArea()
        
        FVTextFieldView(text: $password)
            .setTitleText("Password")
            .setPlaceholderText("Enter Password")
            .setSecureText(true)
            .padding(20)
    }
}

#Preview("Error") {
    @Previewable @State var name = ""
    @Previewable @State var errorText = "Error message"
    @Previewable @State var showError = true
    
    ZStack {
        Color.grayscale600.ignoresSafeArea()
        
        FVTextFieldView(text: $name)
            .setTitleText("First name here")
            .setPlaceholderText("First name here")
            .setError(errorText: $errorText, error: $showError)
            .padding(20)
    }
}
