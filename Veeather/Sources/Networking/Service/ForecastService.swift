import Networking

protocol ForecastServiceProtocol {
    func getForecastForParis(then: @escaping (Result<[Forecast],Error>) -> Void)
}

final class ForecastService: ForecastServiceProtocol {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func getForecastForParis(then: @escaping (Result<[Forecast],Error>) -> Void) {
        apiClient
            .perform(request: ForecastRequest()) { [weak self] result in
                switch result {
                case .failure(let error):
                    then(.failure(error))
                case .success(let response):
                    self?.parse(data: response.data, then: then)
                }
            }
    }

    private struct ForecastResult: Codable {
        let list: [Forecast]
    }

    private func parse(data: Data?, then: @escaping (Result<[Forecast],Error>) -> Void) {
        guard let data = data else {
            then(.failure(ParsinError.decodingError))
            return
        }
        do {
            let forecast = try JSONDecoder().decode(ForecastResult.self, from: data).list
            return then(.success(forecast))
        } catch let error {
            return then(.failure(error))
        }
    }

}

enum ParsinError: Error {
    case decodingError
}
