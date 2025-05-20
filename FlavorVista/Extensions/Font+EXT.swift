//
//  Font+EXT.swift
//  FlavorVista
//
//  Created by Abdulkarim Koshak on 5/20/25.
//  © 2025 Macromin Solutions Pvt. Ltd. All rights reserved.
//
//  Description:
//  This file extends SwiftUI's `Font` and `Font.TextStyle` to integrate
//  a custom font system (`SpaceGrotesk`) across the FlavorVista app.
//  It maps standard text styles to specific font weights and sizes.
//

import SwiftUI

// MARK: - Custom Font Accessor

extension Font {
    
    /// Returns a custom `Font` for the FlavorVista app, using the `SpaceGrotesk` family.
    /// It maps the standard `Font.TextStyle` to a matching weight and size.
    ///
    /// - Parameter fontStyle: The text style to map (e.g. .title, .body).
    /// - Returns: A custom `Font` with appropriate weight and size.
    static func flavorVista(fontStyle: Font.TextStyle = .body) -> Font {
        custom(CustomFont(weight: fontStyle.weight).rawValue, size: fontStyle.size)
    }
}

// MARK: - Font.TextStyle Helpers

extension Font.TextStyle {
    
    /// Maps each `Font.TextStyle` to a specific font size.
    var size: CGFloat {
        switch self {
        case .largeTitle:   return 34
        case .title:        return 28
        case .title2:       return 24
        case .title3:       return 20
        case .headline:     return 18
        case .subheadline:  return 15
        case .body:         return 17
        case .callout:      return 16
        case .footnote:     return 13
        case .caption:      return 18
        case .caption2:     return 15
        @unknown default:   return 16 // Default fallback
        }
    }
    
    /// Maps each `Font.TextStyle` to a specific `Font.Weight`.
    var weight: Font.Weight {
        switch self {
        case .largeTitle, .title, .title2, .title3:
            return .bold
        case .headline, .caption, .caption2:
            return .semibold
        case .subheadline, .callout:
            return .medium
        case .body, .footnote:
            return .regular
        @unknown default:
            return .regular // Fallback for future cases
        }
    }
}

// MARK: - Custom Font Enum

/// Enum representing the different font weights in the SpaceGrotesk family,
/// mapped to their respective font file names.
enum CustomFont: String {
    case bold = "SpaceGrotesk-Bold"
    case light = "SpaceGrotesk-Light"
    case medium = "SpaceGrotesk-Medium"
    case regular = "SpaceGrotesk-Regular"
    case semibold = "SpaceGrotesk-SemiBold"
    
    /// Initializes the custom font based on a given `Font.Weight`.
    ///
    /// - Parameter weight: The weight to convert into a corresponding custom font.
    init(weight: Font.Weight) {
        switch weight {
        case .bold:
            self = .bold
        case .light:
            self = .light
        case .medium:
            self = .medium
        case .regular:
            self = .regular
        case .semibold:
            self = .semibold
        default:
            self = .regular // Default fallback
        }
    }
}
