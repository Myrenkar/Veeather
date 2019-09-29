@testable import Veeather

extension Forecast {
    static func fixture() -> [Forecast] {
        let data = Data.forecastData
        let decoded = try! JSONDecoder().decode(ForecastResult.self, from: data)
        return decoded.list
    }

    private struct ForecastResult: Codable {
        let list: [Forecast]
    }
}
