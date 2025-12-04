import SwiftUI

struct AboutView: View {

    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // HEADER
                HStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.white.opacity(0.05))
                            .frame(width: 72, height: 72)
                        Image(systemName: "scribble.variable")
                            .font(.system(size: 34))
                            .foregroundColor(Theme.accent)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Gesture Playbook")
                            .font(Theme.googleFont("Rubik-Bold", size: 24))
                        Text("Tactical Gesture Engine")
                            .font(Theme.googleFont("Rubik-Regular", size: 14))
                            .foregroundColor(.white.opacity(0.6))
                    }
                }
                .padding(.top, 10)

                // DESCRIPTION
                Text("Turn finger-drawn gestures into animated tactical plays for any sport. Designed with neon trail visuals, a dark tactical grid, and a clean SwiftUI timeline editor.")
                    .font(.callout)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.vertical, 4)


                // FEATURES
                VStack(alignment: .leading, spacing: 12) {
                    Text("Key Features")
                        .font(Theme.googleFont("Rubik-Bold", size: 17))

                    feature(icon: "hand.draw", title: "Gesture Recorder",
                            desc: "Draw plays naturally like on a playboard with neon strokes.")

                    feature(icon: "timeline.selection", title: "Timing Editor",
                            desc: "Fine-tune timing and motion of strokes for animation.")

                    feature(icon: "play.circle.fill", title: "Animate Tactics",
                            desc: "Preview fluid animated plays instantly.")

                    feature(icon: "square.grid.3x3", title: "Formations Library",
                            desc: "Use preset formations or create your own player layouts.")

                    feature(icon: "shareplay", title: "Export Motion",
                            desc: "Share your animated tactics across apps.")
                }
                .padding()
                .background(Color.white.opacity(0.04))
                .cornerRadius(14)


                // VERSION + BUILD
                VStack(alignment: .leading, spacing: 8) {
                    Text("Version")
                        .font(Theme.googleFont("Rubik-Bold", size: 17))

                    HStack {
                        Text("App Version")
                        Spacer()
                        Text(appVersion)
                    }
                    .foregroundColor(.white.opacity(0.7))

                    HStack {
                        Text("Build Number")
                        Spacer()
                        Text(buildNumber)
                    }
                    .foregroundColor(.white.opacity(0.7))
                }
                .padding()
                .background(Color.white.opacity(0.04))
                .cornerRadius(14)


                // LINKS
                VStack(alignment: .leading, spacing: 14) {
                    Text("Support Us")
                        .font(Theme.googleFont("Rubik-Bold", size: 17))

                    //linkRow(icon: "globe", text: "Website", color: .blue)
                    //linkRow(icon: "paperplane", text: "Send Feedback", color: .green)
                    linkRow(icon: "star.circle", text: "Rate the App", color: .yellow)
                }
                .padding()
                .background(Color.white.opacity(0.04))
                .cornerRadius(14)


                Spacer(minLength: 40)
            }
            .padding()
        }
    }

    // MARK: - COMPONENTS

    private func feature(icon: String, title: String, desc: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(Theme.lime)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(Theme.googleFont("Rubik-Medium", size: 16))
                Text(desc)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
        }
    }

    private func linkRow(icon: String, text: String, color: Color) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 18))
            Text(text)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.4))
        }
        .padding(.vertical, 4)
    }

    private func tech(_ name: String) -> some View {
        HStack {
            Circle()
                .fill(Theme.lime.opacity(0.7))
                .frame(width: 8, height: 8)
            Text(name)
        }
        .foregroundColor(.white.opacity(0.8))
    }
}

#Preview {
    AboutView()
}


#Preview {
    AboutView()
}
