import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State private var page: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "scribble.variable")
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .foregroundColor(Theme.accent)
                .neonGlow(Theme.accent, radius: 30)

            Text(["Turn tactics into gestures","Repeatable animated sequences","Export motion diagrams"][page])
                .font(Theme.googleFont("Rubik-Bold", size: 22))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            Text(["Record finger paths for players or ball movement.", "Animate the recorded gestures as repeatable plays.", "Export beautiful neon motion diagrams to PNG/PDF."][page])
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Spacer()
            HStack {
                ForEach(0..<3) { i in
                    Circle()
                        .frame(width: 8, height: 8)
                        .opacity(i == page ? 1 : 0.2)
                        .foregroundColor(Theme.accent)
                }
            }

            HStack(spacing: 16) {
                Button(action: { hasSeenOnboarding = true }) {
                    Text("Skip")
                        .font(Theme.googleFont("Rubik-Regular", size: 15))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.white.opacity(0.04)).cornerRadius(10)
                }
                Spacer()
                Button(action: {
                    if page < 2 { page += 1 } else { hasSeenOnboarding = true }
                }) {
                    HStack {
                        Text(page < 2 ? "Next" : "Get Started")
                        Image(systemName: "chevron.right")
                    }
                    .font(Theme.googleFont("Rubik-Medium", size: 15))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 18)
                    .background(Theme.accent.opacity(0.12))
                    .cornerRadius(12)
                    .neonGlow(Theme.accent, radius: 14)
                }
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 30)
        }
        .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
        .cornerRadius(18)
        .padding(24)
        .shadow(color: Theme.accent.opacity(0.16), radius: 40, x: 0, y: 20)
    }
}
