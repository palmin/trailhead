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

    func forecast(at coordinate: Coordinate) async throws -> Forecast {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let (current, daily) = try await WeatherService.shared.weather(for: location,
                                                                       including: .current, .daily)
        return Forecast(
            temperature: current.temperature,
            symbol: current.symbolName,
            precipitationChance: daily.first?.precipitationChance ?? 0,
            sunset: daily.first?.sun.sunrise
        )
    }
}
