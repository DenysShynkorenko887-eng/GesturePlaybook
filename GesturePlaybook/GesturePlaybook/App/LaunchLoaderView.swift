import SwiftUI

struct LaunchLoaderView: View {
    @State private var rotate = false
    @State private var fadeIn = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.92).ignoresSafeArea()

            VStack(spacing: 24) {

                Image(systemName: "scribble.variable")
                    .font(.system(size: 50))
                    .foregroundStyle(Theme.accent)
                    .rotationEffect(.degrees(rotate ? 360 : 0))
                    .animation(.linear(duration: 1.2).repeatForever(autoreverses: false), value: rotate)

                Text("Gesture Playbook")
                    .font(Theme.googleFont("Rubik-Bold", size: 24))
                    .opacity(fadeIn ? 1 : 0)
                    .animation(.easeOut(duration: 1.0), value: fadeIn)

                ProgressView()
                    .scaleEffect(1.4)
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(Theme.accent)
                    .opacity(fadeIn ? 1 : 0)
                    .animation(.easeOut(duration: 0.6).delay(0.2), value: fadeIn)
            }
        }
        .onAppear {
            rotate = true
            fadeIn = true
        }
    }
}


#Preview {
    LaunchLoaderView()
}
