import SwiftUI

struct TrailList: View {
    @Environment(TrailStore.self) private var store
    @State private var search = ""
    @State private var difficulty: Trail.Difficulty?

    private var trails: [Trail] {
        store.trails
            .filter { difficulty == nil || $0.difficulty == difficulty }
            .filter { search.isEmpty || $0.name.localizedStandardContains(search) }
            .sorted { $0.distance < $1.distance }
    }

    var body: some View {
        NavigationStack {
            List(trails) { trail in
                NavigationLink(value: trail) {
                    TrailRow(trail: trail)
                }
            }
            .navigationTitle("Trails")
            .navigationDestination(for: Trail.self) { trail in
                TrailDetail(trail: trail)
            }
            .searchable(text: $search, prompt: "Search trails")
            .toolbar {
                Menu("Difficulty", systemImage: "line.3.horizontal.decrease") {
                    Picker("Difficulty", selection: $difficulty) {
                        Text("All").tag(Trail.Difficulty?.none)
                        ForEach(Trail.Difficulty.allCases, id: \.self) { level in
                            Text(level.rawValue.capitalized).tag(Optional(level))
                        }
                    }
                }
            }
            .refreshable { await store.reload() }
        }
    }
}

struct TrailRow: View {
    let trail: Trail

    var body: some View {
        HStack(spacing: 12) {
            ElevationSparkline(profile: trail.profile)
                .frame(width: 56, height: 32)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text(trail.name)
                    .font(.headline)
                Text("\(trail.region) · \(trail.distance.formatted())")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            DifficultyBadge(level: trail.difficulty)
        }
    }
}
