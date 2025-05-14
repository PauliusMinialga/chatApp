import Foundation
import PlaySDK

// Define PlaySpacing type if it's missing from PlaySDK
public typealias PlaySpacing = CGFloat

extension Spacing {
    // Registered from play
    static var registeredFoundations: [String: PlaySpacing] = [:]
    
    // Design system spacing values - using 8pt as base unit
    static let none: CGFloat = 0
    static let xxxs: CGFloat = 2
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8 // Base unit
    static let sm: CGFloat = 12
    static let md: CGFloat = 16 // 2× base unit - standard margin
    static let lg: CGFloat = 24 // 3× base unit
    static let xl: CGFloat = 32 // 4× base unit - section spacing
    static let xxl: CGFloat = 40
    static let xxxl: CGFloat = 48
    static let xxxxl: CGFloat = 64
    
    // Component-specific spacing
    struct Components {
        // Navigation
        static let navigationBarHeight: CGFloat = 44
        
        // Message bubbles
        static let messageBubbleHorizontalPadding: CGFloat = 12
        static let messageBubbleVerticalPadding: CGFloat = 8
        static let messageBubbleSpacing: CGFloat = 4
        static let messageGroupSpacing: CGFloat = 16
        
        // Input area
        static let inputAreaMinHeight: CGFloat = 54
        static let inputAreaPadding: CGFloat = 8
        
        // List items
        static let chatListItemHeight: CGFloat = 76
        static let avatarSmallSize: CGFloat = 36
        static let avatarMediumSize: CGFloat = 52
        static let avatarLargeSize: CGFloat = 96
    }
}
