import Networking
import XCTest
@testable import Veeather

final class CityViewModelTests: XCTestCase {
    var sut: CityViewModel!
    var serviceMock: ForecastServiceMock!

    override func setUp() {
        super.setUp()
        serviceMock = ForecastServiceMock()
        sut = CityViewModel(service: serviceMock)
    }

    override func tearDown() {
        sut = nil
        serviceMock = nil
        super.tearDown()
    }

    func testIfViewModelReturnsProperData() {
        // Arrange
        serviceMock.result = .success(Forecast.fixture())

        // Act
        sut.refresh()

        // Assert
        XCTAssertTrue(serviceMock.methodWasCalled)
        XCTAssertEqual(sut.forecasts.value.count, 40)
        XCTAssertNil(sut.error.value)
    }

    func testIfViewModelReturnsProperError() {
        // Arrange
        serviceMock.result = .failure(SampleError.sample)

        // Act
        sut.refresh()

        // Assert
        XCTAssertTrue(serviceMock.methodWasCalled)
        XCTAssert(sut.error.value is SampleError)
        XCTAssertEqual(sut.forecasts.value.count, 0)
    }

    func testIfViewModelReturnsProperErrorAfterRefresh() {
        // Arrange
        serviceMock.result = .success(Forecast.fixture())

        // Act
        sut.refresh()

        XCTAssertEqual(sut.forecasts.value.count, 40)

        serviceMock.result = .failure(SampleError.sample)

        sut.refresh()

        // Assert
        XCTAssertTrue(serviceMock.methodWasCalled)
        XCTAssert(sut.error.value is SampleError)
    }
}

private enum SampleError: Error, Equatable {
    case sample
}
