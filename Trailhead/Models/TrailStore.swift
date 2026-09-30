import Foundation
import CoreLocation
import Observation

@Observable
final class TrailStore {
    private(set) var trails: [Trail] = []
    private(set) var error: Error?
    var location: CLLocation?

    // straight-line distance to the start of a trail, or zero before the location is known
    func distance(to trail: Trail) -> CLLocationDistance {
        guard let location else { return 0 }
        let start = CLLocation(latitude: trail.start.latitude, longitude: trail.start.longitude)
        return location.distance(from: start)
    }

    func reload() async {
        do {
            let url = Bundle.main.url(forResource: "trails", withExtension: "json")!
            let data = try Data(contentsOf: url)
            trails = try JSONDecoder().decode([Trail].self, from: data)
        } catch {
            self.error = error
        }
    }
}
