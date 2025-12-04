import SwiftUI

extension View {
    func neonGlow(_ color: Color, radius: CGFloat = 12, intensity: Double = 0.6) -> some View {
        self
            .shadow(color: color.opacity(intensity), radius: radius, x: 0, y: 0)
            .shadow(color: color.opacity(intensity/2), radius: radius/2, x: 0, y: 0)
    }
}
