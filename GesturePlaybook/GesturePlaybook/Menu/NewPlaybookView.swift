import SwiftUI

struct NewPlaybookView: View {
    @ObservedObject private var store = PlaybookStore.shared

    @State private var showPopup = false
    @State private var editingPlay: PlayModel? = nil     // NEW

    var body: some View {
        ZStack {

            // MAIN SCREEN
            VStack(alignment: .leading) {

                HStack {
                    Text("Playbooks")
                        .font(Theme.googleFont("Rubik-Bold", size: 26))

                    Spacer()

                    Button {
                        editingPlay = nil
                        withAnimation(.spring(duration: 0.25)) {
                            showPopup = true
                        }
                    } label: {
                        Label("New Play", systemImage: "plus")
                            .padding(12)
                            .background(Theme.lime.opacity(0.18))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                .padding(.top)

                // LIST
                List {
                    ForEach(store.plays) { play in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(play.title).font(.headline)
                                Text("Strokes: \(play.strokes.count) • Duration: \(String(format: "%.1f", play.duration))s")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding(.vertical, 6)
                        .listRowBackground(Color.clear)
                        .onTapGesture {
                            withAnimation {
                                editingPlay = play     
                                showPopup = true
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .background(Color.clear)
            }
            .blur(radius: showPopup ? 5 : 0)
            .animation(.easeInOut(duration: 0.22), value: showPopup)


            // POPUP OVERLAY
            if showPopup {
                Color.black.opacity(0.45)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        closePopup()
                    }
            }

            // POPUP WINDOW
            if showPopup {
                NewPlayPopup(
                    playToEdit: editingPlay,      // pass null or play
                    onSave: { updatedPlay in
                        saveEdited(updatedPlay)
                    },
                    onClose: { closePopup() }
                )
                .transition(.scale.combined(with: .opacity))
                .zIndex(10)
            }
        }
    }

    func closePopup() {
        withAnimation(.spring(duration: 0.25)) {
            showPopup = false
        }
    }

    func saveEdited(_ play: PlayModel) {
        if let idx = store.plays.firstIndex(where: { $0.id == play.id }) {
            store.plays[idx] = play
        } else {
            store.plays.append(play)
        }
        closePopup()
    }
}



struct GestureStroke: Identifiable, Codable {
    let id = UUID()
    var points: [CGPoint]
    var colorHex: String = "00E5FF"
    var width: CGFloat = 6
}

struct PlayModel: Identifiable, Codable {
    let id: UUID
    var title: String
    var strokes: [GestureStroke]
    var duration: Double = 2.0

    init(id: UUID = UUID(), title: String, strokes: [GestureStroke], duration: Double = 2.0) {
        self.id = id
        self.title = title
        self.strokes = strokes
        self.duration = duration
    }
}


class PlaybookStore: ObservableObject {
    @Published var plays: [PlayModel] = []

    static let shared = PlaybookStore()

    private init() {
        // sample data
        plays = [PlayModel(title: "Sample Play", strokes: [GestureStroke(points: [CGPoint(x: 40, y: 40), CGPoint(x: 200, y: 80), CGPoint(x: 320, y: 480)], colorHex: "FF4EC8", width: 8)])]
    }
}

#Preview {
    NewPlaybookView()
}
