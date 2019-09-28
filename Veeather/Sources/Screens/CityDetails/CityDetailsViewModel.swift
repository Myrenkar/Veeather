protocol CityDetailsViewModelProtocol {
    var information: ImmutableObservable<String> { get }
    var title: String { get }
}

struct CityDetailsViewModel: CityDetailsViewModelProtocol {

    private let forecast: Forecast

    init(forecast: Forecast) {
        self.forecast = forecast
    }

    var information: ImmutableObservable<String> {
        return Observable(forecast.weather.first?.information.capitalized ?? "No information")
    }

    var title: String { return "Paris" }
    
}
