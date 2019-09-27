import Networking

/// Describes a type that is providing application dependencies.
protocol ApplicationDependenciesProvider {
    var apiClient: APIClient { get }
    var weatherFactory: WeatherFactoryProtocol { get }
}

final class DefaultApplicationDependenciesProvider: ApplicationDependenciesProvider {

    lazy var apiClient: APIClient = {
       return DefaultAPIClient()
    }()

    lazy var weatherFactory: WeatherFactoryProtocol = {
        return WeatherFactory()
    }()
}
