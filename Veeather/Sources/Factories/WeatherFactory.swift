protocol WeatherFactoryProtocol {
    func buildCityViewController() -> CityViewController
}

final class WeatherFactory: WeatherFactoryProtocol {
    func buildCityViewController() -> CityViewController {
        return CityViewController()
    }
}
