import Networking

/// Describes a type that is providing application dependencies.
protocol ApplicationDependenciesProvider {
    var apiClient: APIClient { get }
    var weatherFactory: WeatherFactoryProtocol { get }
    var iconProvider: IconProviding { get }
}

final class DefaultApplicationDependenciesProvider: ApplicationDependenciesProvider {

    lazy var apiClient: APIClient = {
       return DefaultAPIClient()
    }()

    lazy var weatherFactory: WeatherFactoryProtocol = {
        let service = ForecastService(apiClient: self.apiClient)
        return WeatherFactory(service: service, iconProvider: self.iconProvider)
    }()

    lazy var iconProvider: IconProviding = {
        return IconProvider(imageProvider: ImageProvider())
    }()
}
