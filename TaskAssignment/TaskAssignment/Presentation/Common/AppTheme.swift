import UIKit

enum AppTheme {
    // MARK: - Colors
    enum Colors {
        static let background = UIColor(red: 0.09, green: 0.13, blue: 0.20, alpha: 1.0) // Dark blue background
        static let cardBackground = UIColor(red: 0.12, green: 0.17, blue: 0.25, alpha: 1.0) // Slightly lighter card background
        static let primaryBlue = UIColor(red: 0.20, green: 0.60, blue: 0.86, alpha: 1.0) // Icon blue
        static let textPrimary = UIColor.white
        static let textSecondary = UIColor(red: 0.60, green: 0.65, blue: 0.70, alpha: 1.0) // Gray text
        static let accent = UIColor(red: 0.20, green: 0.60, blue: 0.86, alpha: 1.0)
    }
    
    // MARK: - Fonts
    enum Fonts {
        static func bold(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
        
        static func semibold(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        
        static func regular(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        
        static func medium(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .medium)
        }
    }
    
    // MARK: - Spacing
    enum Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    // MARK: - Corner Radius
    enum CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let circle: CGFloat = 999
    }
}
