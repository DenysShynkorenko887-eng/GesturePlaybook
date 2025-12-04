import SwiftUI
struct GestureCanvas: View {
    @Binding var strokes: [GestureStroke]
    @Binding var currentStroke: [CGPoint]
    @Binding var width: CGFloat
    @Binding var colorHex: String

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Existing strokes
                ForEach(strokes) { stroke in
                    Path { path in
                        guard let first = stroke.points.first else { return }
                        path.move(to: first)
                        path.addLines(stroke.points)
                    }
                    .stroke(Color(hex: stroke.colorHex), lineWidth: stroke.width)
                }

                // Current stroke
                Path { path in
                    guard let first = currentStroke.first else { return }
                    path.move(to: first)
                    path.addLines(currentStroke)
                }
                .stroke(Color(hex: colorHex), lineWidth: width)
            }
            .contentShape(Rectangle())
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let p = value.location
                    currentStroke.append(p)
                }
                .onEnded { _ in
                    if currentStroke.count > 1 {
                        strokes.append(
                            GestureStroke(points: currentStroke, colorHex: colorHex, width: width)
                        )
                    }
                    currentStroke = []
                }
            )
        }
    }
}
