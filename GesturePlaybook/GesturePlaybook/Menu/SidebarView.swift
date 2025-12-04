import SwiftUI

struct SidebarView: View {
    @Binding var selection: MenuItem
    var onSettingsTapped: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {

            // Header
            HStack {
                Image(systemName: "scribble.variable")
                    .font(.system(size: 26))
                    .foregroundStyle(Theme.accent)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Gesture Playbook")
                        .font(Theme.googleFont("Rubik-Bold", size: 15))
                    Text("Gestural tactics for any sport")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            .padding(.bottom, 8)

            // Menu items
            ForEach(MenuItem.allCases, id: \.self) { item in
                Button(action: { selection = item }) {
                    HStack {
                        Image(systemName: iconName(for: item))
                        Text(item.rawValue)
                            .font(Theme.googleFont("Rubik-Regular", size: 14))
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .buttonStyle(.plain)
            }

            Spacer()

            // Settings button
            Button(action: { onSettingsTapped() }) {
                HStack {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .foregroundColor(.white.opacity(0.75))
                .font(Theme.googleFont("Rubik-Regular", size: 13))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
    }

    func iconName(for item: MenuItem) -> String {
        switch item {
        case .newPlaybook: return "plus.viewfinder"
        case .gestureRecorder: return "hand.draw"
        case .animateTactics: return "play.circle"
        case .formationsLibrary: return "square.grid.3x3"
        case .timingEditor: return "clock.arrow.2.circlepath"
        case .exportMotion: return "square.and.arrow.up"
        case .about: return "info.circle"
        }
    }
}
