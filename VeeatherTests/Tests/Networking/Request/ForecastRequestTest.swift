import Networking
import XCTest
@testable import Veeather

final class ForecastRequestTest: XCTestCase {
    var sut: ForecastRequest!

    override func setUp() {
        super.setUp()
        sut = ForecastRequest()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testIfRequestIsValid() {
        XCTAssertEqual(sut.path, "forecast")
        XCTAssertEqual(sut.method, HTTPMethod.get)
        XCTAssertEqual(sut.urlBuilder.host, "api.openweathermap.org")
        XCTAssertEqual(sut.urlBuilder.root, "data")
        XCTAssertEqual(sut.urlBuilder.version, "2.5")
    }

    func testQuery() {
        let query: [String: APIQueryParameter] = ["q": .string("Paris,fr"),
                     "units": .string("metric"),
                     "appid": .string("8b5b220d7784b5e85266ed5b729edcb3")
        ]
        XCTAssertEqual(sut.query, query)

    }
}
