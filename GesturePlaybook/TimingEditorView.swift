import SwiftUI

struct TimingEditorView: View {
    @State private var selectedPlay: PlayModel? = PlaybookStore.shared.plays.first
    @State private var tempo: Double = 1.0

    var body: some View {
        VStack(alignment: .leading) {
            Text("Timing Editor")
                .font(Theme.googleFont("Rubik-Bold", size: 20))
                .padding()
            Form {
                Section(header: Text("Play")) {
                    Picker("Play", selection: Binding(get: { selectedPlay?.id }, set: { id in selectedPlay = PlaybookStore.shared.plays.first(where: { $0.id == id }) })) {
                        ForEach(PlaybookStore.shared.plays) { p in Text(p.title).tag(p.id as UUID?) }
                    }
                }
                Section(header: Text("Tempo & Duration")) {
                    HStack {
                        Text("Tempo")
                        Slider(value: $tempo, in: 0.5...2.5, step: 0.1)
                            .accentColor(Theme.accent)
                        Text(String(format: "%.1fx", tempo))
                    }
                    if let p = selectedPlay {
                        HStack {
                            Text("Duration: \(String(format: "%.1f", p.duration * tempo))s")
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}
