import SwiftUI

struct Theme {
    // Neon palette (hex)
    static let bg = Color(hex: "0B0F14")
    static let accent = Color(hex: "00E5FF") // cyan neon
    static let magenta = Color(hex: "FF4EC8")
    static let lime = Color(hex: "A6FF4E")
    static let tactical = Color(hex: "2B9AF3")
    static let softGlow = Color(hex: "12222A")

    static func googleFont(_ name: String, size: CGFloat) -> Font {
        // fallback if custom font not present
        if UIFont(name: name, size: size) != nil {
            return Font.custom(name, size: size)
        }
        return Font.system(size: size, weight: .regular)
    }
}
