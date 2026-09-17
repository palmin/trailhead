import SwiftUI
import Charts

struct ElevationChart: View {
    let trail: Trail

    private var points: [(distance: Double, elevation: Double)] {
        let step = trail.distance.converted(to: .kilometers).value / Double(max(trail.profile.count - 1, 1))
        return trail.profile.enumerated().map { (Double($0.offset) * step, $0.element) }
    }

    var body: some View {
        Chart(points, id: \.distance) { point in
            AreaMark(
                x: .value("Distance", point.distance),
                y: .value("Elevation", point.elevation)
            )
            .foregroundStyle(.linearGradient(colors: [.green.opacity(0.5), .green.opacity(0.05)],
                                             startPoint: .top, endPoint: .bottom))
            LineMark(
                x: .value("Distance", point.distance),
                y: .value("Elevation", point.elevation)
            )
            .foregroundStyle(.green)
            .interpolationMethod(.catmullRom)
        }
        .chartXAxisLabel("km")
        .chartYAxisLabel("m")
    }
}
