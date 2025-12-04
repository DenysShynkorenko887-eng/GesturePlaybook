import SwiftUI

struct GestureRecorderView: View {
    @State private var currentStroke: [CGPoint] = []
    @State private var strokes: [GestureStroke] = []
    @State private var width: CGFloat = 6
    @State private var colorHex: String = "00E5FF"
    @ObservedObject private var store = PlaybookStore.shared
    @State private var showSaveSheet = false
    @State private var playName: String = "New Play"
    @State private var showOpenSheet = false

    var body: some View {
        VStack(spacing: 12) {
            // HEADER
            HStack {
                Text("Gesture Recorder")
                    .font(Theme.googleFont("Rubik-Bold", size: 20))
                Spacer()

                // OPEN button
                Button(action: { showOpenSheet = true }) {
                    Image(systemName: "folder")
                        .foregroundColor(Theme.accent)
                        .padding(8)
                        .background(Color.white.opacity(0.07))
                        .cornerRadius(8)
                }

                // CLEAR
                Button(action: {
                    strokes.removeAll()
                    currentStroke.removeAll()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(Theme.magenta)
                        .padding(8)
                        .background(Color.white.opacity(0.07))
                        .cornerRadius(8)
                }

                // SAVE
                Button(action: { showSaveSheet = true }) {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(Theme.accent)
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showOpenSheet) {
                NavigationView {
                    List {
                        ForEach(store.plays) { play in
                            Button {
                                load(play)
                                showOpenSheet = false
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(play.title).font(.headline)
                                        Text("Strokes: \(play.strokes.count)")
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.6))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .navigationTitle("Open Play")
                    .navigationBarItems(trailing: Button("Close") {
                        showOpenSheet = false
                    })
                }
            }


            // DRAWING SPACE
            ZStack {
                DrawingGrid()

                GestureCanvas(
                    strokes: $strokes,
                    currentStroke: $currentStroke,
                    width: $width,
                    colorHex: $colorHex
                )
                .cornerRadius(12)
                .padding()
                .background(Color.black.opacity(0.12))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.05)))
            }
            .frame(height: 520)

            // CONTROLS
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Width: \(Int(width))")
                    Slider(value: $width, in: 2...18, step: 1).accentColor(Theme.accent)
                }

                VStack(alignment: .leading) {
                    Text("Color")
                    HStack {
                        ForEach(["00E5FF", "FF4EC8", "A6FF4E", "2B9AF3"], id: \.self) { hex in
                            SmallColorPicker(hex: hex, selectedHex: $colorHex)
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }

        // SAVE SHEET
        .sheet(isPresented: $showSaveSheet) {
            NavigationView {
                VStack(spacing: 12) {
                    TextField("Play name", text: $playName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Save") {
                        let play = PlayModel(
                            title: playName,
                            strokes: strokes
                        )
                        store.plays.append(play)

                        // Reset canvas
                        strokes.removeAll()
                        currentStroke.removeAll()

                        showSaveSheet = false
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("Save Play")
                .navigationBarItems(
                    trailing: Button("Cancel") { showSaveSheet = false }
                )
            }
        }
    }
    func load(_ play: PlayModel) {
        playName = play.title
        strokes = play.strokes
        currentStroke = []
        
        // Optionally reset brush settings
        if let first = play.strokes.first {
            colorHex = first.colorHex
            width = first.width
        }
    }

}


#Preview {
    GestureRecorderView()
}
