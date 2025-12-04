import SwiftUI

struct DrawingFieldBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.black.opacity(0.14))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.04)))
    }
}
