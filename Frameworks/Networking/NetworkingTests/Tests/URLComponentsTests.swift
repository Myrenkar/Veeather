@testable import Networking

import XCTest

final class URLComponentsTests: XCTestCase {

    var sut: URLComponents!
    var apiRequest: APIRequest!

    override func setUp() {
        super.setUp()
        apiRequest = FixtureRequest()
        sut = URLComponents(request: apiRequest)
    }

    override func tearDown() {
        apiRequest = nil
        sut = nil
        super.tearDown()
    }

    func testComponentsSetProperly() {
        XCTAssertEqual(sut.host, apiRequest.urlBuilder.host)
        XCTAssertEqual(sut.queryItems, apiRequest.serializeToQuery())
        XCTAssertEqual(sut.scheme, apiRequest.urlBuilder.scheme.rawValue)
        XCTAssertEqual(sut.path, "/fixed.root/-1/fixture.path")
    }
}
