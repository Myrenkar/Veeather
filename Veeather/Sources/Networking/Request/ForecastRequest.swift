import Networking

struct ForecastRequest: APIRequest {
    var method: Method { return .get }

    var path: String { return "forecast" }
    var query: [String : APIQueryParameter] {
        return [
            "id" : .int(6455259),
            "units": .string("metric")
        ]
    }
}

extension APIRequest {
    var urlBuilder: APIURLBuilder { return OpenWeatherBuilder() }
}
