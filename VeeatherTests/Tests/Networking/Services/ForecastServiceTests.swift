import XCTest
import Networking
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

    func testIfServiceReturnsProperResponseWithErrorData() {
        apiClient.errorResult = .failure(APIError.internetConnectionUnavailable)
        sut.getForecastForParis { (result) in
            if case let .failure(error) = result, let unrwappedError = error as? APIError {
                XCTAssertEqual(unrwappedError, APIError.internetConnectionUnavailable)
            } else {
                XCTFail("Wrong result")
            }
        }
    }

    func testIfServiceReturnsProperResponseWithSuccessData() {
        apiClient.errorResult = .success(APIResponse.fixture)
        sut.getForecastForParis { (result) in
            if case let .success(reponse) = result {
                // This should have 5 items as we would like to has 5 days forecast
                XCTAssertEqual(reponse.count, 5)
            } else {
                XCTFail("Wrong result")
            }
        }
    }
}
