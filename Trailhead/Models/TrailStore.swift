import Foundation
import Observation

@Observable
final class TrailStore {
    private(set) var trails: [Trail] = []
    private(set) var error: Error?

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
