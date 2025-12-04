import SwiftUI

struct ImageRenderer {
    var play: PlayModel
    var size = CGSize(width: 1200, height: 800)

    func render() -> UIImage? {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        return renderer.image { ctx in
            let bg = UIColor(red: 11/255, green: 15/255, blue: 20/255, alpha: 1)
            bg.setFill(); ctx.fill(CGRect(origin: .zero, size: size))

            for stroke in play.strokes {
                guard stroke.points.count > 1 else { continue }
                let path = UIBezierPath()
                path.lineWidth = stroke.width * 3
                path.lineCapStyle = .round
                let scaleX = size.width / 375 // assumes normalized 375 width view
                let scaleY = size.height / 667
                let p0 = stroke.points[0]
                path.move(to: CGPoint(x: p0.x * scaleX, y: p0.y * scaleY))
                for p in stroke.points.dropFirst() {
                    path.addLine(to: CGPoint(x: p.x * scaleX, y: p.y * scaleY))
                }
                let cgColor = UIColor(Color(hex: stroke.colorHex))
                cgColor.setStroke()
                path.stroke()
            }
        }
    }
}
