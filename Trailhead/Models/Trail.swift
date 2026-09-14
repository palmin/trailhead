import Foundation
import CoreLocation

struct Trail: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var region: String
    var distance: Measurement<UnitLength>
    var elevationGain: Double
    var difficulty: Difficulty
    var start: Coordinate
    var profile: [Double]

    enum Difficulty: String, Codable, CaseIterable {
        case easy, moderate, hard
    }
}

struct Coordinate: Codable, Hashable {
    var latitude: Double
    var longitude: Double

    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
