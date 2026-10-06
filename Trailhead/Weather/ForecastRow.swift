import SwiftUI

struct ForecastRow: View {
    let forecast: Forecast

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: forecast.symbol)
                .symbolRenderingMode(.multicolor)
                .font(.largeTitle)
            VStack(alignment: .leading, spacing: 2) {
                Text(forecast.temperature.formatted(.measurement(width: .narrow)))
                    .font(.title2.bold())
                Text("\(forecast.precipitationChance.formatted(.percent)) chance of rain")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if let sunset = forecast.sunset {
                Label(sunset.formatted(date: .omitted, time: .shortened), systemImage: "sunset.fill")
                    .foregroundStyle(.orange)
            }
        }
        .padding()
        .background(.background.secondary, in: .rect(cornerRadius: 16))
    }
}
