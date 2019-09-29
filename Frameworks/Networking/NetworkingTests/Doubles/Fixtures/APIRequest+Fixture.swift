@testable import Networking

struct FixtureRequest: APIRequest {
    var method: HTTPMethod { return .get }
    var path: String { return "fixture.path" }
    var urlBuilder: APIURLBuilder { return FixtureURLBuilder() }
    var query: [String : APIQueryParameter] {
        return [
            "id" : .string("fixed_id")
        ]
    }
}

struct FixtureURLBuilder: APIURLBuilder {
    var host: String { return "fixed.host" }
    var root: String { return "fixed.root" }
    var scheme: Scheme { return .https }
    var version: String { return "-1" }
}
