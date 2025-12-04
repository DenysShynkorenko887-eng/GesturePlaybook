import SwiftUI

struct NeonPath: View {
    var points: [CGPoint]
    var lineWidth: CGFloat = 6
    var color: Color = Theme.accent

    var body: some View {
        GeometryReader { geo in
            if points.count > 1 {
                Path { path in
                    path.move(to: points[0])
                    for i in 1..<points.count {
                        path.addLine(to: points[i])
                    }
                }
                .strokedPath(StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .overlay(
                    Path { path in
                        path.move(to: points[0])
                        for i in 1..<points.count { path.addLine(to: points[i]) }
                    }
                    .stroke(color.opacity(0.35), style: StrokeStyle(lineWidth: lineWidth * 2, lineCap: .round, lineJoin: .round))
                )
                .overlay(
                    Path { path in
                        path.move(to: points[0])
                        for i in 1..<points.count { path.addLine(to: points[i]) }
                    }
                    .stroke(LinearGradient(gradient: Gradient(colors: [color, color.opacity(0.6)]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                )
                .neonGlow(color, radius: 18, intensity: 0.7)
            }
        }
    }
}
