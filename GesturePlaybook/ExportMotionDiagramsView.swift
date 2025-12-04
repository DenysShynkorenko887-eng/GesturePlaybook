import SwiftUI

struct ExportMotionDiagramsView: View {
    @ObservedObject private var store = PlaybookStore.shared
    @State private var selectedPlay: PlayModel?
    @State private var showShare: Bool = false
    @State private var exportImage: UIImage?

    var body: some View {
        VStack {
            HStack {
                Text("Export Motion Diagrams")
                    .font(Theme.googleFont("Rubik-Bold", size: 20))
                Spacer()
                Button(action: { if let p = store.plays.first { selectedPlay = p; export(play: p) } }) { Image(systemName: "square.and.arrow.up").foregroundColor(Theme.accent) }
            }
            .padding()

            List(store.plays) { p in
                HStack {
                    VStack(alignment: .leading) {
                        Text(p.title)
                        Text("Strokes: \(p.strokes.count)")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    Spacer()
                    Button(action: { selectedPlay = p; export(play: p) }) {
                        Image(systemName: "square.and.arrow.up").foregroundColor(Theme.accent)
                    }
                }
            }
        }
        .sheet(isPresented: $showShare) {
            if let img = exportImage {
                ActivityView(activityItems: [img])
            } else { Text("Preparing...") }
        }
    }

    func export(play: PlayModel) {
        // Render a UIView snapshot of the play and show share sheet
        let renderer = ImageRenderer(play: play)
        if let img = renderer.render() {
            exportImage = img
            showShare = true
        }
    }
}
