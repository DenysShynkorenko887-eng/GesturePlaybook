import SwiftUI
import Combine
import UIKit

struct AnimatorView: View {
    let play: PlayModel
    @Binding var progress: Double // 0..1
    @Binding var isPlaying: Bool
    @State private var displayTimer: AnyCancellable?

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(play.strokes) { stroke in
                    NeonPath(points: stroke.points, lineWidth: stroke.width, color: Color(hex: stroke.colorHex)).opacity(0.7)
                }

                // moving markers for each stroke
                ForEach(Array(play.strokes.enumerated()), id: \ .offset) { idx, stroke in
                    let point = pointAt(progress: progressForStroke(index: idx, stroke: stroke))
                    Circle()
                        .frame(width: 14, height: 14)
                        .position(point)
                        .neonGlow(Color(hex: stroke.colorHex), radius: 18)
                        .animation(.easeInOut(duration: 0.1), value: progress)
                }
            }
            .onChange(of: isPlaying) { playing in
                if playing {
                    startTimer()
                } else {
                    stopTimer()
                }
            }
            .onAppear {
                if isPlaying { startTimer() }
            }
            .onDisappear { stopTimer() }
        }
    }

    func startTimer() {
        stopTimer()
        displayTimer = Timer.publish(every: 0.016, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                withAnimation(.linear(duration: 0.016)) {
                    progress += 0.016 / max(0.0001, play.duration)
                    if progress >= 1 { progress = 0 }
                }
            }
    }
    func stopTimer() { displayTimer?.cancel(); displayTimer = nil }

    // Map overall progress to stroke-specific progress (simple equal timing for all strokes)
    func progressForStroke(index: Int, stroke: GestureStroke) -> Double {
        guard play.strokes.count > 0 else { return progress }
        // weight by stroke point count
        return progress
    }

    func pointAt(progress: Double) -> CGPoint {
        // For demo: place at center when no points
        guard play.strokes.count > 0 else { return CGPoint(x: 100, y: 100) }
        // We'll compute for the first stroke per call, but callers pass different stroke via progressForStroke.
        // Simpler approach: sample first stroke of play
        let stroke = play.strokes.first!
        return sample(points: stroke.points, t: progress)
    }

    func sample(points: [CGPoint], t: Double) -> CGPoint {
        guard points.count > 1 else { return points.first ?? .zero }
        let total = Double(points.count - 1)
        let scaled = t * total
        let idx = min(Int(floor(scaled)), points.count - 2)
        let localT = scaled - Double(idx)
        let a = points[idx]
        let b = points[idx + 1]
        let x = a.x + (b.x - a.x) * CGFloat(localT)
        let y = a.y + (b.y - a.y) * CGFloat(localT)
        return CGPoint(x: x, y: y)
    }
}
