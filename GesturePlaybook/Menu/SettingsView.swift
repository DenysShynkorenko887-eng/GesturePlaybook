import SwiftUI

struct SettingsView: View {

    // User toggles
    @AppStorage("hapticsEnabled") private var hapticsEnabled = true
    @AppStorage("neonGlowEnabled") private var neonGlowEnabled = true
    @AppStorage("defaultStrokeWidth") private var defaultStrokeWidth: Double = 6
    @AppStorage("playSpeed") private var playSpeed: Double = 1.0

    @State private var showResetAlert = false
    @State private var showClearPlaysAlert = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {

                    // MARK: ---  APPEARANCE  ---
                    SectionHeader("Appearance")
                    VStack(spacing: 16) {

                        toggleRow(
                            icon: "sparkles",
                            title: "Neon Glow",
                            subtitle: "Enable glowing trails",
                            binding: $neonGlowEnabled
                        )

                        VStack(alignment: .leading, spacing: 6) {
                            settingsLabel(icon: "line.horizontal.3.decrease", title: "Default Stroke Width")
                            Slider(value: $defaultStrokeWidth, in: 2...18, step: 1)
                            Text("\(Int(defaultStrokeWidth)) px")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .padding()
                        .background(Color.white.opacity(0.04))
                        .cornerRadius(14)
                    }


                    // MARK: ---  INTERACTION  ---
                    SectionHeader("Interaction")
                    VStack(spacing: 16) {

                        toggleRow(
                            icon: "iphone.radiowaves.left.and.right",
                            title: "Haptic Feedback",
                            subtitle: "Vibrate when drawing or editing",
                            binding: $hapticsEnabled
                        )
                    }


                    // MARK: ---  PLAYBACK  ---
                    SectionHeader("Playback")
                    VStack(spacing: 16) {

                        VStack(alignment: .leading, spacing: 6) {
                            settingsLabel(icon: "play.circle.fill", title: "Playback Speed")
                            Slider(value: $playSpeed, in: 0.3...2.0, step: 0.1)
                            Text("\(String(format: "%.1fx", playSpeed))")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .padding()
                        .background(Color.white.opacity(0.04))
                        .cornerRadius(14)
                    }


                    // MARK: --- NAVIGATION LINKS ---
                    SectionHeader("App Info")

                    VStack(spacing: 1) {
                        settingsNavLink(
                            icon: "info.circle",
                            title: "About",
                            destination: AboutView()
                        )

                        settingsNavLink(
                            icon: "square.grid.3x3",
                            title: "Formations Library",
                            destination: FormationsLibraryView()
                        )
                    }
                    .background(Color.white.opacity(0.04))
                    .cornerRadius(14)


                    // MARK: --- DATA MANAGEMENT ---
                    SectionHeader("Data Management")

                    VStack(spacing: 12) {
                        destructiveButton(title: "Clear All Saved Plays", icon: "trash") {
                            showClearPlaysAlert = true
                        }

                        destructiveButton(title: "Reset All Settings", icon: "arrow.counterclockwise") {
                            showResetAlert = true
                        }
                    }
                    .padding(.top, 4)

                    Spacer(minLength: 40)
                }
                .padding()
            }
            .navigationTitle("Settings")
            .background(Color.black.opacity(0.95))
        }

        // MARK: --- ALERTS ---
        .alert("Clear all plays?", isPresented: $showClearPlaysAlert) {
            Button("Delete All", role: .destructive) {
                PlaybookStore.shared.plays.removeAll()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will permanently delete all saved gesture plays.")
        }

        .alert("Reset all settings?", isPresented: $showResetAlert) {
            Button("Reset", role: .destructive) {
                resetToDefaults()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Your preferences will be restored to default values.")
        }
    }


    // MARK: --- RESET LOGIC ---
    func resetToDefaults() {
        hapticsEnabled = true
        neonGlowEnabled = true
        defaultStrokeWidth = 6
        playSpeed = 1.0
    }


    // MARK: --- COMPONENT BUILDERS ---

    @ViewBuilder
    private func SectionHeader(_ text: String) -> some View {
        Text(text)
            .font(Theme.googleFont("Rubik-Bold", size: 18))
            .foregroundColor(.white.opacity(0.9))
    }

    @ViewBuilder
    private func settingsLabel(icon: String, title: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundColor(Theme.accent)
            Text(title)
                .font(Theme.googleFont("Rubik-Medium", size: 16))
        }
    }

    private func toggleRow(icon: String, title: String, subtitle: String?, binding: Binding<Bool>) -> some View {
        HStack(alignment: .top) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(Theme.accent)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(Theme.googleFont("Rubik-Medium", size: 16))
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
            }

            Spacer()
            Toggle("", isOn: binding)
                .labelsHidden()
        }
        .padding()
        .background(Color.white.opacity(0.04))
        .cornerRadius(14)
    }

    private func settingsNavLink<Destination: View>(
        icon: String,
        title: String,
        destination: Destination
    ) -> some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(Theme.accent)
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding()
        }
    }

    private func destructiveButton(title: String, icon: String, action: @escaping () -> Void) -> some View {
        Button(role: .destructive) { action() } label: {
            HStack {
                Image(systemName: icon)
                Text(title)
                Spacer()
            }
            .foregroundColor(.red)
            .padding()
            .background(Color.red.opacity(0.1))
            .cornerRadius(14)
        }
    }
}



#Preview {
    SettingsView()
}
