import SwiftUI
import Combine
import UIKit

// MARK: - App Entry
@main
struct GesturePlaybookApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State private var showLaunch = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                AppBackgroundView()

                if showLaunch {
                    LaunchLoaderView()
                        .transition(.opacity)
                } else {
                    if !hasSeenOnboarding {
                        OnboardingView()
                    } else {
                        MainShellView()
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        showLaunch = false
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
 

extension UIColor {
    convenience init(_ color: Color) {
        let components = color.components()
        self.init(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }
}

extension Color {
    func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let ui = UIColor(self)
        var r: CGFloat = 0; var g: CGFloat = 0; var b: CGFloat = 0; var a: CGFloat = 0
        ui.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a)
    }
}
 
