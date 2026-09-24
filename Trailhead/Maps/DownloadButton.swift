import SwiftUI

struct DownloadButton: View {
    let trail: Trail
    @Environment(OfflineMaps.self) private var maps

    var body: some View {
        switch maps.state(for: trail) {
        case .none:
            Button("Download Map", systemImage: "arrow.down.circle") {
                Task { try await maps.download(trail) }
            }
        case .downloading(let progress):
            ProgressView(value: progress)
                .progressViewStyle(.circular)
        case .downloaded(let bytes):
            Menu("Downloaded", systemImage: "checkmark.circle.fill") {
                Text(bytes.formatted(.byteCount(style: .file)))
                Button("Remove Download", systemImage: "trash", role: .destructive) {
                    maps.remove(trail)
                }
            }
        }
    }
}
