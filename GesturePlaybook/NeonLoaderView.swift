import SwiftUI

struct NeonLoaderView: View {
    @State private var progress: CGFloat = 0
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6)
                .frame(width: 64, height: 64)
                .opacity(0.08)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .frame(width: 64, height: 64)
                .rotationEffect(.degrees(-90))
                .neonGlow(Theme.accent, radius: 20)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: progress)
        }
        .onAppear { progress = 1 }
    }
}
