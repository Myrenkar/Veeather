protocol CityViewModelProtocol {
    var forecasts: ImmutableObservable<[Forecast]> { get }
    var error: ImmutableObservable<Error?> { get }
    func refresh()
}

final class CityViewModel: CityViewModelProtocol {
    private let service: ForecastServiceProtocol
    private let forecastsSubject = Observable<[Forecast]>([])
    private let errorSubject = Observable<Error?>(nil)


    init(service: ForecastServiceProtocol) {
        self.service = service
    }

    var forecasts: ImmutableObservable<[Forecast]> {
        return forecastsSubject.asImmutable()
    }

    var error: ImmutableObservable<Error?> {
        return errorSubject.asImmutable()
    }

    func refresh() {
        service.getForecastForParis { [weak self] result in
            switch result {
            case .success(let items):
                self?.forecastsSubject.value = items
            case .failure(let error):
                self?.errorSubject.value = error
            }

        }
    }
}
