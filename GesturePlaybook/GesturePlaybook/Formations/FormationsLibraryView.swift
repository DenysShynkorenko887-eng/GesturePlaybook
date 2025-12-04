import SwiftUI

struct FormationModel: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var sport: String
    var points: [CGPoint] // Player positions normalized 0–1
}

struct FormationsLibraryView: View {

    @State private var search = ""
    @State private var selectedCategory = "All"
    @State private var showDetail: FormationModel?
    @State private var formations: [FormationModel] = [
        
        FormationModel(name: "4-4-2 Generic", sport: "Soccer",
                           points: [
                               CGPoint(x: 0.5, y: 0.10),
                               CGPoint(x: 0.25, y: 0.25), CGPoint(x: 0.75, y: 0.25),
                               CGPoint(x: 0.2, y: 0.45), CGPoint(x: 0.4, y: 0.45),
                               CGPoint(x: 0.6, y: 0.45), CGPoint(x: 0.8, y: 0.45),
                               CGPoint(x: 0.3, y: 0.75), CGPoint(x: 0.7, y: 0.75),
                               CGPoint(x: 0.5, y: 0.90)
                           ]),
            FormationModel(name: "3-2-3-2", sport: "Soccer",
                           points: [
                               CGPoint(x: 0.5, y: 0.10),
                               CGPoint(x: 0.33, y: 0.25), CGPoint(x: 0.66, y: 0.25), CGPoint(x: 0.5, y: 0.35),
                               CGPoint(x: 0.4, y: 0.55), CGPoint(x: 0.6, y: 0.55),
                               CGPoint(x: 0.2, y: 0.75), CGPoint(x: 0.4, y: 0.75),
                               CGPoint(x: 0.6, y: 0.75), CGPoint(x: 0.8, y: 0.75)
                           ]),
            FormationModel(name: "2-3 Zone Defense", sport: "Basketball",
                           points: [
                               CGPoint(x: 0.3, y: 0.2), CGPoint(x: 0.7, y: 0.2),
                               CGPoint(x: 0.2, y: 0.5), CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.8, y: 0.5)
                           ]),
            FormationModel(name: "Rugby Spread", sport: "Rugby",
                           points: [
                               CGPoint(x: 0.1, y: 0.4), CGPoint(x: 0.25, y: 0.4), CGPoint(x: 0.4, y: 0.4),
                               CGPoint(x: 0.55, y: 0.4), CGPoint(x: 0.7, y: 0.4), CGPoint(x: 0.85, y: 0.4)
                           ]),

            FormationModel(name: "5-3-2 Counter Press", sport: "Soccer",
                           points: [
                               CGPoint(x: 0.5, y: 0.08),
                               CGPoint(x: 0.2, y: 0.25), CGPoint(x: 0.4, y: 0.25), CGPoint(x: 0.6, y: 0.25), CGPoint(x: 0.8, y: 0.25),
                               CGPoint(x: 0.33, y: 0.45), CGPoint(x: 0.66, y: 0.45), CGPoint(x: 0.5, y: 0.55),
                               CGPoint(x: 0.3, y: 0.78), CGPoint(x: 0.7, y: 0.78)
                           ]),

            FormationModel(name: "Diamond Midfield", sport: "Soccer",
                           points: [
                               CGPoint(x: 0.5, y: 0.1),
                               CGPoint(x: 0.25, y: 0.3), CGPoint(x: 0.75, y: 0.3),
                               CGPoint(x: 0.5, y: 0.42),
                               CGPoint(x: 0.33, y: 0.6), CGPoint(x: 0.66, y: 0.6),
                               CGPoint(x: 0.5, y: 0.8)
                           ]),

            FormationModel(name: "1-3-1 Press", sport: "Basketball",
                           points: [
                               CGPoint(x: 0.5, y: 0.12),
                               CGPoint(x: 0.5, y: 0.3),
                               CGPoint(x: 0.25, y: 0.48), CGPoint(x: 0.75, y: 0.48),
                               CGPoint(x: 0.5, y: 0.75)
                           ]),

            FormationModel(name: "Box-and-One Defense", sport: "Basketball",
                           points: [
                               CGPoint(x: 0.3, y: 0.2), CGPoint(x: 0.7, y: 0.2),
                               CGPoint(x: 0.3, y: 0.55), CGPoint(x: 0.7, y: 0.55),
                               CGPoint(x: 0.5, y: 0.38)
                           ]),

            FormationModel(name: "Rugby Blitz Defense", sport: "Rugby",
                           points: [
                               CGPoint(x: 0.1, y: 0.35), CGPoint(x: 0.25, y: 0.38),
                               CGPoint(x: 0.4, y: 0.41), CGPoint(x: 0.55, y: 0.38),
                               CGPoint(x: 0.7, y: 0.35), CGPoint(x: 0.85, y: 0.32),
                               CGPoint(x: 0.5, y: 0.55)
                           ]),

            FormationModel(name: "Rugby Stacked Attack", sport: "Rugby",
                           points: [
                               CGPoint(x: 0.15, y: 0.2), CGPoint(x: 0.3, y: 0.25), CGPoint(x: 0.45, y: 0.3),
                               CGPoint(x: 0.6, y: 0.35), CGPoint(x: 0.75, y: 0.3), CGPoint(x: 0.9, y: 0.25)
                           ]),

            FormationModel(name: "Hockey 1-2-2 Forecheck", sport: "Hockey",
                           points: [
                               CGPoint(x: 0.5, y: 0.1),
                               CGPoint(x: 0.33, y: 0.3), CGPoint(x: 0.66, y: 0.3),
                               CGPoint(x: 0.25, y: 0.55), CGPoint(x: 0.75, y: 0.55)
                           ]),

            FormationModel(name: "Hockey Umbrella Powerplay", sport: "Hockey",
                           points: [
                               CGPoint(x: 0.5, y: 0.15),
                               CGPoint(x: 0.25, y: 0.35), CGPoint(x: 0.75, y: 0.35),
                               CGPoint(x: 0.4, y: 0.6), CGPoint(x: 0.6, y: 0.6)
                           ]),
        

            FormationModel(name: "4-3-3 Wide Control", sport: "Soccer",
                           points: [
                               CGPoint(x: 0.5, y: 0.1),
                               CGPoint(x: 0.2, y: 0.27), CGPoint(x: 0.5, y: 0.27), CGPoint(x: 0.8, y: 0.27),
                               CGPoint(x: 0.33, y: 0.48), CGPoint(x: 0.5, y: 0.55), CGPoint(x: 0.66, y: 0.48),
                               CGPoint(x: 0.3, y: 0.78), CGPoint(x: 0.7, y: 0.78), CGPoint(x: 0.5, y: 0.9)
                           ]),

            FormationModel(name: "3-5-1-1 Flex", sport: "Soccer",
                           points: [
                               CGPoint(x: 0.5, y: 0.1),
                               CGPoint(x: 0.33, y: 0.25), CGPoint(x: 0.66, y: 0.25), CGPoint(x: 0.5, y: 0.32),
                               CGPoint(x: 0.2, y: 0.48), CGPoint(x: 0.4, y: 0.48), CGPoint(x: 0.6, y: 0.48), CGPoint(x: 0.8, y: 0.48),
                               CGPoint(x: 0.5, y: 0.7), CGPoint(x: 0.5, y: 0.9)
                           ]),

            FormationModel(name: "1-1-3-1 Trap", sport: "Basketball",
                           points: [
                               CGPoint(x: 0.5, y: 0.1),
                               CGPoint(x: 0.5, y: 0.25),
                               CGPoint(x: 0.25, y: 0.45), CGPoint(x: 0.5, y: 0.45), CGPoint(x: 0.75, y: 0.45),
                               CGPoint(x: 0.5, y: 0.7)
                           ]),

            FormationModel(name: "Triangle-and-Two Defense", sport: "Basketball",
                           points: [
                               CGPoint(x: 0.3, y: 0.2), CGPoint(x: 0.7, y: 0.2),
                               CGPoint(x: 0.3, y: 0.55), CGPoint(x: 0.7, y: 0.55),
                               CGPoint(x: 0.5, y: 0.38), CGPoint(x: 0.5, y: 0.75)
                           ]),

            FormationModel(name: "Rugby Double Sweep", sport: "Rugby",
                           points: [
                               CGPoint(x: 0.15, y: 0.3), CGPoint(x: 0.3, y: 0.35), CGPoint(x: 0.45, y: 0.4),
                               CGPoint(x: 0.6, y: 0.35), CGPoint(x: 0.75, y: 0.3),
                               CGPoint(x: 0.5, y: 0.52), CGPoint(x: 0.5, y: 0.75)
                           ]),

            FormationModel(name: "Rugby Arrowhead Attack", sport: "Rugby",
                           points: [
                               CGPoint(x: 0.5, y: 0.2),
                               CGPoint(x: 0.33, y: 0.35), CGPoint(x: 0.66, y: 0.35),
                               CGPoint(x: 0.25, y: 0.5), CGPoint(x: 0.5, y: 0.55), CGPoint(x: 0.75, y: 0.5),
                               CGPoint(x: 0.5, y: 0.8)
                           ]),

            FormationModel(name: "Hockey Box PK", sport: "Hockey",
                           points: [
                               CGPoint(x: 0.3, y: 0.25), CGPoint(x: 0.7, y: 0.25),
                               CGPoint(x: 0.3, y: 0.55), CGPoint(x: 0.7, y: 0.55),
                               CGPoint(x: 0.5, y: 0.1)
                           ]),

            FormationModel(name: "Hockey 1-3-1 Powerplay Plus", sport: "Hockey",
                           points: [
                               CGPoint(x: 0.5, y: 0.12),
                               CGPoint(x: 0.25, y: 0.3), CGPoint(x: 0.75, y: 0.3),
                               CGPoint(x: 0.15, y: 0.48), CGPoint(x: 0.5, y: 0.52), CGPoint(x: 0.85, y: 0.48)
                           ]),

            FormationModel(name: "Volleyball W Formation", sport: "Volleyball",
                           points: [
                               CGPoint(x: 0.2, y: 0.2), CGPoint(x: 0.5, y: 0.2), CGPoint(x: 0.8, y: 0.2),
                               CGPoint(x: 0.33, y: 0.5), CGPoint(x: 0.66, y: 0.5),
                               CGPoint(x: 0.5, y: 0.75)
                           ]),

            FormationModel(name: "Volleyball Stack Rotation", sport: "Volleyball",
                           points: [
                               CGPoint(x: 0.5, y: 0.15),
                               CGPoint(x: 0.25, y: 0.35), CGPoint(x: 0.75, y: 0.35),
                               CGPoint(x: 0.33, y: 0.55), CGPoint(x: 0.66, y: 0.55),
                               CGPoint(x: 0.5, y: 0.85)
                           ])
        ]


    let categories = ["All", "Soccer", "Basketball", "Rugby"]

    var filtered: [FormationModel] {
        formations.filter { f in
            (selectedCategory == "All" || f.sport == selectedCategory) &&
            (search.isEmpty || f.name.lowercased().contains(search.lowercased()))
        }
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {

                // HEADER
                HStack {
                    Text("Formations Library")
                        .font(Theme.googleFont("Rubik-Bold", size: 26))

                    Spacer()

                    Button {
                        addNew()
                    } label: {
                        Label("New Formation", systemImage: "plus")
                            .foregroundColor(Theme.accent)
                            .padding(10)
                            .background(Theme.lime.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.top)

                // SEARCH FIELD
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search formations…", text: $search)
                }
                .padding(10)
                .background(Color.white.opacity(0.06))
                .cornerRadius(10)
                .padding(.horizontal)

                // CATEGORY FILTER
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 6)
                                .background(cat == selectedCategory ? Theme.lime.opacity(0.3) : Color.white.opacity(0.05))
                                .cornerRadius(10)
                                .onTapGesture { selectedCategory = cat }
                        }
                    }
                    .padding(.horizontal)
                }

                // GRID OF FORMATIONS
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 18), count: 2), spacing: 18) {
                        ForEach(filtered) { f in
                            FormationCard(f)
                                .onTapGesture {
                                    withAnimation(.spring(duration: 0.25)) {
                                        showDetail = f
                                    }
                                }
                        }
                    }
                    .padding()
                }
            }

            // DETAIL POPUP
            if let selected = showDetail {
                FormationDetailPopup(
                    formation: selected,
                    onDelete: {
                        formations.removeAll { $0.id == selected.id }
                        showDetail = nil
                    },
                    onDuplicate: {
                        var copy = selected
                        copy.name += " Copy"
                        formations.append(copy)
                    },
                    onClose: {
                        withAnimation(.spring(duration: 0.25)) {
                            showDetail = nil
                        }
                    }
                )
                .zIndex(10)
                .transition(.scale.combined(with: .opacity))
            }
        }
    }

    func addNew() {
        let new = FormationModel(name: "New Custom", sport: "Soccer", points: [])
        formations.append(new)
        showDetail = new
    }
}


#Preview {
    FormationsLibraryView()
}
