import Foundation
import MapKit
import Observation

// map tiles around a trail, downloaded so the map works without a signal
@Observable
final class OfflineMaps {
    enum State: Equatable {
        case none
        case downloading(progress: Double)
        case downloaded(bytes: Int64)
    }

    private(set) var states: [Trail.ID: State] = [:]

    func state(for trail: Trail) -> State {
        states[trail.id] ?? .none
    }

    func download(_ trail: Trail) async throws {
        let tiles = TileRange(around: trail.start, radius: 6_000, zoom: 12...16)
        var bytes: Int64 = 0
        for (index, tile) in tiles.enumerated() {
            let data = try await TileCache.shared.fetch(tile)
            bytes += Int64(data.count)
            states[trail.id] = .downloading(progress: Double(index + 1) / Double(tiles.count))
        }
        states[trail.id] = .downloaded(bytes: bytes)
    }

    func remove(_ trail: Trail) {
        TileCache.shared.removeTiles(around: trail.start)
        states[trail.id] = nil
    }
}
