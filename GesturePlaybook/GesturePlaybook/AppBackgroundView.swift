import SwiftUI

struct AppBackgroundView: View {
    var body: some View {
        ZStack {
            Theme.bg
                .ignoresSafeArea()
            LinearGradient(gradient: Gradient(colors: [Theme.bg.opacity(0.9), Theme.softGlow.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .blendMode(.overlay)
                .ignoresSafeArea()
            VStack { Spacer() }
        }
    }
}
