protocol WeatherFactoryProtocol {
    func buildCityViewController() -> CityViewController
}

final class WeatherFactory: WeatherFactoryProtocol {
    private let service: ForecastServiceProtocol

    init(service: ForecastServiceProtocol) {
        self.service = service
    }

    func buildCityViewController() -> CityViewController {
        let viewModel = CityViewModel(service: service)
        return CityViewController(viewModel: viewModel)
    }
}
