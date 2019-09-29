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


extension Data {
    static var forecastData: Data {
        return try! JSONEncoder().encode(Forecast.fixture())
    }
}

