import SwiftUI

struct DrawingGrid: View {
    var body: some View {
        GeometryReader { geo in
            Path { path in
                let spacing: CGFloat = 30

                for x in stride(from: 0, through: geo.size.width, by: spacing) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: geo.size.height))
                }

                for y in stride(from: 0, through: geo.size.height, by: spacing) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: geo.size.width, y: y))
                }
            }
            .stroke(Color.white.opacity(0.06), lineWidth: 0.5)
        }
    }
}
