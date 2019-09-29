import XCTest
@testable import Veeather

final class ForecastServiceMock: ForecastServiceProtocol {
    var methodWasCalled = false
    var result: (Result<[Forecast], Error>)?
    func getForecastForParis(then: @escaping (Result<[Forecast], Error>) -> Void) {
        methodWasCalled = true
        then(result!)
    }
}
