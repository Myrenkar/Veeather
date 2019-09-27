import Networking

struct ForecastRequest: APIRequest {
    var method: Method { return .get }

    var path: String { return "forecast" }
    var query: [String : APIQueryParameter] {
        return [
            "id" : .int(6455259),
            "units" : .string("metric"),
            "appid" : .string("8b5b220d7784b5e85266ed5b729edcb3")
        ]
    }
}

extension APIRequest {
    var urlBuilder: APIURLBuilder { return OpenWeatherBuilder() }
}
