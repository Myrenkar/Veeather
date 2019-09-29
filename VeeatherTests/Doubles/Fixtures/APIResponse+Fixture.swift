@testable import Veeather
import Networking
import Foundation

extension APIResponse {
    static var fixture: APIResponse {
        return APIResponse(data: Data.forecastData,
                           response: HTTPURLResponse.fixture
                )
    }
}

extension HTTPURLResponse {
    static var fixture: HTTPURLResponse {
        return HTTPURLResponse(url: URL(string: "fixed.url")!,
                       statusCode: 200,
                       httpVersion: nil,
                       headerFields: [:]
        )!
    }
}

private class PrivateToken {}

extension Data {
    static var forecastData: Data {
        let path = Bundle(for: PrivateToken.self).path(forResource: "forecast", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        return data!
    }
}

