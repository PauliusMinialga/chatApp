import Foundation
import PlaySDK
import SwiftUI

// Define PlayTypography if it's missing from PlaySDK
public typealias PlayTypography = [String: Any]

extension Typography {
    // Registered from play
    static var registeredFoundations: [String: PlayTypography] = [:]
    
    // Text styles based on design system
    struct TextStyle {
        let font: Font
        let lineSpacing: CGFloat
        
        init(size: CGFloat, weight: Font.Weight = .regular, lineSpacing: CGFloat = 0) {
            self.font = Font.system(size: size, weight: weight)
            self.lineSpacing = lineSpacing
        }
    }
    
    // Design system text styles
    static let header = TextStyle(size: 20, weight: .semibold, lineSpacing: 6)
    static let subheader = TextStyle(size: 17, weight: .medium, lineSpacing: 5)
    static let body = TextStyle(size: 15, weight: .regular, lineSpacing: 4)
    static let caption = TextStyle(size: 13, weight: .regular, lineSpacing: 3)
    static let small = TextStyle(size: 11, weight: .regular, lineSpacing: 2)
}

// SwiftUI View extension to easily apply text styles
extension Text {
    func textStyle(_ style: Typography.TextStyle) -> some View {
        self.font(style.font)
            .lineSpacing(style.lineSpacing)
    }
}

// SwiftUI View extensions for each style
extension View {
    func headerStyle() -> some View {
        return self.modifier(TextStyleModifier(style: Typography.header))
    }
    
    func subheaderStyle() -> some View {
        return self.modifier(TextStyleModifier(style: Typography.subheader))
    }
    
    func bodyStyle() -> some View {
        return self.modifier(TextStyleModifier(style: Typography.body))
    }
    
    func captionStyle() -> some View {
        return self.modifier(TextStyleModifier(style: Typography.caption))
    }
    
    func smallStyle() -> some View {
        return self.modifier(TextStyleModifier(style: Typography.small))
    }
}

// Text style view modifier
struct TextStyleModifier: ViewModifier {
    let style: Typography.TextStyle
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
            .lineSpacing(style.lineSpacing)
    }
}
