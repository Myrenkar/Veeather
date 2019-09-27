import Networking

final class OpenWeatherBuilder: APIURLBuilder {
    var scheme: Scheme { return .http }
    var host: String { return "api" }
    var root: String { return "openweathermap.org/data" }
    var version: String { return "2.5" }
}
