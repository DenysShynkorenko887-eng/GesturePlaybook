import SwiftUI

struct StrokeCanvasView: View {

    @Binding var strokes: [GestureStroke]
    @Binding var currentStroke: GestureStroke

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Past strokes
                ForEach(strokes) { stroke in
                    Path { path in
                        guard let first = stroke.points.first else { return }
                        path.move(to: first)
                        for p in stroke.points { path.addLine(to: p) }
                    }
                    .stroke(Color(hex: stroke.colorHex), lineWidth: stroke.width)
                }

                // Currently drawing stroke
                Path { path in
                    guard let first = currentStroke.points.first else { return }
                    path.move(to: first)
                    for p in currentStroke.points { path.addLine(to: p) }
                }
                .stroke(Color(hex: currentStroke.colorHex), lineWidth: currentStroke.width)
            }

            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0.1)
                    .onChanged { value in
                        let p = value.location
                        currentStroke.points.append(p)
                    }
                    .onEnded { _ in
                        if !currentStroke.points.isEmpty {
                            strokes.append(currentStroke)
                        }
                        currentStroke = GestureStroke(points: [], colorHex: currentStroke.colorHex, width: currentStroke.width)
                    }
            )
        }
    }
}
