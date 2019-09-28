protocol WeatherFactoryProtocol {
    func buildCityViewController(delegate: CityViewControllerDelegate) -> CityViewController
    func buildCityDetailsViewController(for forecast: Forecast) -> CityDetailsViewController
}

final class WeatherFactory: WeatherFactoryProtocol {
    private let service: ForecastServiceProtocol
    private let iconProvider: IconProviding

    init(service: ForecastServiceProtocol, iconProvider: IconProviding) {
        self.service = service
        self.iconProvider = iconProvider
    }

    func buildCityViewController(delegate: CityViewControllerDelegate) -> CityViewController {
        let viewModel = CityViewModel(service: service)
        let viewController = CityViewController(viewModel: viewModel, iconProvider: iconProvider)
        viewController.delegate = delegate
        return viewController
    }

    func buildCityDetailsViewController(for forecast: Forecast) -> CityDetailsViewController {
        let viewModel = CityDetailsViewModel(forecast: forecast)
        return CityDetailsViewController(viewModel: viewModel)
    }
}
