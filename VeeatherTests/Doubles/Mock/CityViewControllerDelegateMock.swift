@testable import Veeather

final class CityViewControllerDelegateMock: NSObject, CityViewControllerDelegate {
    var caputerdForecast: Forecast?
    var methodWasCalled = false

    func didTapCity(forecast: Forecast) {
        methodWasCalled = true
        caputerdForecast = forecast
    }
}
