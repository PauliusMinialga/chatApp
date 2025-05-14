import Foundation
import UIKit
import SwiftUI

// MARK: Colors
extension Colors.UIKit {
    // Registered from play
    static var registeredFoundations: [String: UIColor] = [:]

    /// Helper for light/dark mode
    static func themed(playId: String, light: UIColor, dark: UIColor? = nil) -> UIColor {
        return UIColor(dynamicProvider: { ($0.userInterfaceStyle == .dark) ? dark ?? light : light })
    }
}

extension Colors.SwiftUI {
    // Design system colors
    static let primaryBlue = Color(hex: "0084FF") // Message bubbles, CTAs
    static let receivedMessageGray = Color(hex: "F0F0F0") // Received message background
    static let backgroundColor = Color.white
    
    // Text colors
    static let primaryText = Color.black.opacity(0.87)
    static let secondaryText = Color.black.opacity(0.60)
    static let placeholderText = Color.black.opacity(0.40)
    static let invertedText = Color.white
    
    // Status colors
    static let success = Color(hex: "4CD964")
    static let error = Color(hex: "FF3B30")
    static let warning = Color(hex: "FF9500")
}

// Custom Color extension for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
