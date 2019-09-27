import Networking

final class OpenWeatherBuilder: APIURLBuilder {
    var scheme: Scheme { return .http }
    var host: String { return "api.openweathermap.org" }
    var root: String { return "data" }
    var version: String { return "2.5" }
}
