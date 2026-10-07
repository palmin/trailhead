import Foundation
import CoreLocation
import WeatherKit

struct Forecast: Equatable {
    var temperature: Measurement<UnitTemperature>
    var symbol: String
    var precipitationChance: Double
    var sunset: Date?
}

actor TrailWeather {
    static let shared = TrailWeather()

    private var cache: [Coordinate: (forecast: Forecast, fetched: Date)] = [:]
    private let lifetime: TimeInterval = 60 * 60

    func forecast(at coordinate: Coordinate) async throws -> Forecast {
        if let cached = cache[coordinate], cached.fetched.timeIntervalSinceNow > -lifetime {
            return cached.forecast
        }

        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let (current, daily) = try await WeatherService.shared.weather(for: location,
                                                                       including: .current, .daily)
        let forecast = Forecast(
            temperature: current.temperature,
            symbol: current.symbolName,
            precipitationChance: daily.first?.precipitationChance ?? 0,
            sunset: daily.first?.sun.sunrise
        )
        cache[coordinate] = (forecast, .now)
        return forecast
    }
}
