import SwiftUI
import MapKit

struct TrailDetail: View {
    let trail: Trail

    private var region: MKCoordinateRegion {
        MKCoordinateRegion(center: trail.start.location,
                           latitudinalMeters: 4_000, longitudinalMeters: 4_000)
    }

    // in feet where people walk miles
    private var climb: String {
        Measurement(value: trail.elevationGain, unit: UnitLength.meters)
            .formatted(.measurement(width: .abbreviated, usage: .general,
                                    numberFormatStyle: .number.precision(.fractionLength(0))))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Map(initialPosition: .region(region)) {
                    Marker(trail.name, systemImage: "figure.hiking", coordinate: trail.start.location)
                        .tint(.green)
                }
                .frame(height: 240)
                .clipShape(.rect(cornerRadius: 16))

                Grid(alignment: .leading, horizontalSpacing: 24) {
                    GridRow {
                        Stat("Distance", trail.distance.formatted())
                        Stat("Climb", climb)
                        Stat("Level", trail.difficulty.rawValue.capitalized)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(trail.name)
        .toolbar {
            DownloadButton(trail: trail)
        }
    }
}

private struct Stat: View {
    let title: String
    let value: String

    init(_ title: String, _ value: String) {
        self.title = title
        self.value = value
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title3.bold())
        }
    }
}
