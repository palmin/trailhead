import SwiftUI

struct TrailList: View {
    @Environment(TrailStore.self) private var store

    private var trails: [Trail] {
        store.trails
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
            .refreshable { await store.reload() }
        }
    }
}

struct TrailRow: View {
    let trail: Trail

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(trail.name)
                    .font(.headline)
                Text("\(trail.region) · \(trail.distance.formatted())")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}
