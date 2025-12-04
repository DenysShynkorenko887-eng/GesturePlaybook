import SwiftUI

struct SmallColorPicker: View {
    let hex: String
    @Binding var selectedHex: String

    var body: some View {
        Circle()
            .fill(Color(hex: hex))
            .frame(width: 28, height: 28)
            .overlay(
                Circle().stroke(selectedHex == hex ? Color.white : Color.clear, lineWidth: 3)
            )
            .onTapGesture { selectedHex = hex }
    }
}
