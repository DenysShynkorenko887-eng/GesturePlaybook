import SwiftUI

struct FormationCard: View {
    let form: FormationModel

    init(_ f: FormationModel) { self.form = f }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.04))

                GeometryReader { geo in
                    ForEach(form.points.indices, id: \.self) { i in
                        Circle()
                            .fill(Theme.lime)
                            .frame(width: 12, height: 12)
                            .position(
                                x: form.points[i].x * geo.size.width,
                                y: form.points[i].y * geo.size.height
                            )
                    }
                }
            }
            .frame(height: 120)

            Text(form.name)
                .font(.headline)
            Text(form.sport)
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(14)
    }
}
