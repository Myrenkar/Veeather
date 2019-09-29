import Foundation

struct Forecast: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case temparature = "main"
        case weather
        case time = "dt_txt"
    }

    let temparature: Temperature
    let weather: [Weather]
    let time: String
}

struct Weather: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case icon
        case information = "description"
    }

    let information: String
    let icon: String?
}

struct Temperature: Codable, Equatable {
    let temp: Double
}
