import SwiftUI

struct DifficultyBadge: View {
    let level: Trail.Difficulty

    private var color: Color {
        switch level {
        case .easy: .teal
        case .moderate: .orange
        case .hard: .purple
        }
    }

    var body: some View {
        Text(level.rawValue.capitalized)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .foregroundStyle(color)
            .background(color.opacity(0.15), in: .capsule)
            .accessibilityLabel(level.label)
    }
}
