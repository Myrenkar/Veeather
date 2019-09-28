import Networking

struct ForecastRequest: APIRequest {
    var method: HTTPMethod { return .get }

    var path: String { return "forecast" }
    var query: [String : APIQueryParameter] {
        return [
            "q": .string("Paris,fr"),
            "units" : .string("metric"),
            "appid" : .string(Keys.apiToken)
        ]
    }
}

extension APIRequest {
    var urlBuilder: APIURLBuilder { return OpenWeatherBuilder() }
}
