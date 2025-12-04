import SwiftUI

struct NewPlayPopup: View {

    // incoming for edit mode
    var playToEdit: PlayModel?

    // writing fields
    @State private var title: String = ""
    @State private var duration: Double = 2.0
    @State private var strokes: [GestureStroke] = []
    @State private var current: GestureStroke = GestureStroke(points: [])

    @State private var showInputs = true        // arrow to toggle
    @State private var error: String?

    let onSave: (PlayModel) -> Void
    let onClose: () -> Void

    let colors = ["00E5FF", "FF4EC8", "3BFF65", "FFD233", "FF6B3D"]

    var isEditing: Bool {
        playToEdit != nil
    }

    var body: some View {
        VStack(spacing: 16) {

            // HEADER
            HStack {
                Text(isEditing ? "Edit Play" : "Create New Play")
                    .font(Theme.googleFont("Rubik-Bold", size: 20))

                Spacer()

                // arrow toggle
                Button {
                    withAnimation(.easeInOut) {
                        showInputs.toggle()
                    }
                } label: {
                    Image(systemName: showInputs ? "chevron.up" : "chevron.down")
                        .foregroundColor(Theme.accent)
                }
            }

            // COLLAPSIBLE INPUT FIELDS
            if showInputs {
                VStack(alignment: .leading, spacing: 12) {

                    Text("Title")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.65))

                    TextField("Play name", text: $title)
                        .padding(10)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)

                    Text("Duration")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.65))

                    HStack {
                        Slider(value: $duration, in: 0.5...10, step: 0.1)
                            .accentColor(Theme.accent)
                        Text(String(format: "%.1f", duration))
                            .frame(width: 40)
                    }
                }
            }

            // CANVAS
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.05))

                StrokeCanvasView(strokes: $strokes, currentStroke: $current)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .frame(height: 250)

            // STROKE TOOLS
            HStack(spacing: 14) {

                // stroke width slider
                VStack(alignment: .leading) {
                    Slider(value: $current.width, in: 2...20)
                        .accentColor(Theme.accent)
                    Text("Width: \(Int(current.width))")
                        .font(.caption)
                }
                .frame(width: 120)

                // stroke colors
                HStack(spacing: 10) {
                    ForEach(colors, id: \.self) { hex in
                        Circle()
                            .fill(Color(hex: hex))
                            .frame(width: current.colorHex == hex ? 30 : 24)
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: current.colorHex == hex ? 2 : 0)
                            )
                            .onTapGesture { current.colorHex = hex }
                    }
                }

                Spacer()

                Button {
                    if !strokes.isEmpty { strokes.removeLast() }
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .foregroundColor(Theme.accent)
                }

                Button { strokes.removeAll() } label: {
                    Image(systemName: "trash")
                        .foregroundColor(Theme.magenta)
                }
            }
            .font(.title3)

            // ERROR
            if let error = error {
                Text(error).foregroundColor(.red).font(.caption)
            }

            // BUTTONS
            HStack {
                Button("Cancel") { onClose() }
                    .foregroundColor(Theme.magenta)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.white.opacity(0.08))
                    .cornerRadius(8)

                Spacer()

                Button(isEditing ? "Save" : "Create") { save() }
                    .foregroundColor(Theme.accent)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Theme.lime.opacity(0.3))
                    .cornerRadius(8)
            }

        }
        .padding(22)
        .frame(maxWidth: 380)
        .background(Color.black.opacity(0.9))
        .cornerRadius(20)
        .shadow(radius: 20)
        .onAppear { loadIfEditing() }
    }

    func loadIfEditing() {
        guard let p = playToEdit else { return }
        title = p.title
        duration = p.duration
        strokes = p.strokes
    }

    func save() {
        if title.trimmed().isEmpty {
            error = "Title cannot be empty"
            return
        }

        let result = PlayModel(
            id: playToEdit?.id ?? UUID(),
            title: title,
            strokes: strokes,
            duration: duration
        )

        onSave(result)
    }
}

extension String {
    func trimmed() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
