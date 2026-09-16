import SwiftUI

// the elevation profile as a small line, drawn next to each trail in the list
struct ElevationSparkline: View {
    let profile: [Double]

    var body: some View {
        GeometryReader { geometry in
            let low = profile.min() ?? 0
            let high = max(profile.max() ?? 1, low + 1)
            Path { path in
                for (index, elevation) in profile.enumerated() {
                    let x = geometry.size.width * CGFloat(index) / CGFloat(max(profile.count - 1, 1))
                    let y = geometry.size.height * (1 - (elevation - low) / (high - low))
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(.green, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
    }
}
