@testable import Networking

import XCTest

final class URLRequestTests: XCTestCase {

    var sut: URLRequest!
    var apiRequest: APIRequest!

    override func setUp() {
        super.setUp()
        apiRequest = FixtureRequest()
        sut = try! URLRequest(request: apiRequest)
    }

    override func tearDown() {
        apiRequest = nil
        sut = nil
        super.tearDown()
    }

    func testRequestHeadersSetProperly() {
        let headers = [
            "Accept": "application/json",
            "Content-Type": "application/json; charset=uft-8"
        ]
        XCTAssertEqual(sut.allHTTPHeaderFields, headers)
    }

    func testRequestMethodSetProperly() {
        XCTAssertEqual(sut.httpMethod, apiRequest.method.rawValue)
    }
}
