import Foundation

struct Forecast: Codable {
    private enum CodingKeys: String, CodingKey {
           case main
           case weather
           case time = "dt_txt"
    }

    let main: Main
    let weather: Weather
    let time: String
}

struct Weather: Codable {
    let description: String
    let iconId: String
}

struct Main: Codable {
    private enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }

    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Double
}
