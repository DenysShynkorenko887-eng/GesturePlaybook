import SwiftUI

struct FormationDetailPopup: View {
    var formation: FormationModel
    var onDelete: () -> Void
    var onDuplicate: () -> Void
    var onClose: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text(formation.name)
                .font(Theme.googleFont("Rubik-Bold", size: 22))

            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white.opacity(0.05))

                GeometryReader { geo in
                    ForEach(formation.points.indices, id: \.self) { i in
                        Circle()
                            .fill(Theme.lime)
                            .frame(width: 16, height: 16)
                            .position(
                                x: formation.points[i].x * geo.size.width,
                                y: formation.points[i].y * geo.size.height
                            )
                    }
                }
            }
            .frame(height: 280)

            HStack {
                Button("Duplicate", action: onDuplicate)
                    .foregroundColor(Theme.accent)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(10)

                Button("Delete", action: onDelete)
                    .foregroundColor(Theme.magenta)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.3))
                    .cornerRadius(10)
            }
            Button("Close", action: onClose)
                .foregroundColor(Theme.accent)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.12))
                .cornerRadius(10)
        }
        .padding(20)
        .frame(width: 340)
        .background(Color.black.opacity(0.85))
        .cornerRadius(20)
        .shadow(radius: 40)
    }
}
