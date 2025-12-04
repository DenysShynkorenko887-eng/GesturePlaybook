import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let c = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return c
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
