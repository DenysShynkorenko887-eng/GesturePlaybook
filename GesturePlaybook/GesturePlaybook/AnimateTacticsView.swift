import SwiftUI

struct AnimateTacticsView: View {
    @ObservedObject private var store = PlaybookStore.shared
    @State private var selectedPlay: PlayModel?
    @State private var isPlaying: Bool = false
    @State private var playProgress: Double = 0

    var body: some View {
        VStack {
            HStack {
                Text("Animate Tactics")
                    .font(Theme.googleFont("Rubik-Bold", size: 20))
                Spacer()
                Picker("Play", selection: Binding(get: { selectedPlay?.id }, set: { id in selectedPlay = store.plays.first(where: { $0.id == id }) })) {
                    ForEach(store.plays) { p in
                        Text(p.title).tag(p.id as UUID?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                Button(action: togglePlay) { Image(systemName: isPlaying ? "pause.fill" : "play.fill").foregroundColor(Theme.accent) }
            }
            .padding()

            ZStack {
                DrawingFieldBackground()
                if let play = selectedPlay {
                    AnimatorView(play: play, progress: $playProgress, isPlaying: $isPlaying)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                } else {
                    Text("Select a play to preview animations")
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            .frame(height: 520)

            // timeline slider
            HStack {
                Text("0s")
                Slider(value: $playProgress, in: 0...1)
                    .accentColor(Theme.accent)
                Text("1x")
            }
            .padding()
        }
    }

    func togglePlay() {
        guard selectedPlay != nil else { return }
        isPlaying.toggle()
    }
}
