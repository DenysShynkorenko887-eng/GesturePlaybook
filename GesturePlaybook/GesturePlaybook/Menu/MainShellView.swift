import SwiftUI

struct MainShellView: View {
    @State private var selection: MenuItem = .newPlaybook
    @State private var showSidebar = false
    @State private var showSettings = false

    var body: some View {
        ZStack(alignment: .leading) {

            // MAIN CONTENT
            mainContent
                .blur(radius: showSidebar ? 3 : 0)
                .animation(.easeInOut(duration: 0.22), value: showSidebar)

            // DARK BACKDROP WHEN MENU OPEN
            if showSidebar {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { toggleSidebar() }
                    .animation(.easeInOut(duration: 0.22), value: showSidebar)
            }

            // SIDEBAR
            SidebarView(selection: $selection, onSettingsTapped: {
                showSettings = true
                toggleSidebar()
            })
            .frame(width: 230) 
            .background(Color.black.opacity(0.85))
            .offset(x: showSidebar ? 0 : -260)
            .animation(.easeInOut(duration: 0.25), value: showSidebar)
            .zIndex(20)

            // MENU TOGGLE BUTTON (TOP LEFT)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: toggleSidebar) {
                        Image(systemName: showSidebar ? "multiply" : "line.3.horizontal")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .medium))
                            .padding(22)
                            .background(Color.blue.opacity(0.25))
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 12)

                    
                }
                
            }
            .zIndex(30)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()   // Put your settings view here
        }
    }

    var mainContent: some View {
        Group {
            switch selection {
            case .newPlaybook: NewPlaybookView()
            case .gestureRecorder: GestureRecorderView()
            case .animateTactics: AnimateTacticsView()
            case .formationsLibrary: FormationsLibraryView()
            case .timingEditor: TimingEditorView()
            case .exportMotion: ExportMotionDiagramsView()
            case .about: AboutView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func toggleSidebar() {
        withAnimation {
            showSidebar.toggle()
        }
    }
}

#Preview {
    MainShellView()
        .preferredColorScheme(.dark)
}
