import XCTest
@testable import Veeather

final class ForecastServiceTest: XCTestCase {
    var apiClient: APIClientMock!
    var sut: ForecastService!

    override func setUp() {
        super.setUp()
        apiClient = APIClientMock()
        sut = ForecastService(apiClient: apiClient)
    }

    override func tearDown() {
        sut = nil
        apiClient = nil
        super.tearDown()
    }

    func testMethod() {
        XCTAssertEqual(1, 1)
        sut.getForecastForParis { (result) in
        }
    }
}
