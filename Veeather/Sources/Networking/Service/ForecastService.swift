import Networking

protocol ForecastServiceProtocol {
    func getForecastForParis(then: @escaping (Result<[Forecast],Error>) -> Void)
}

final class ForecastService: ForecastServiceProtocol {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    // MARK: - ForecastServiceProtocol

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

    // MARK: - Private
    
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
            return then(.success(calculateFiveDays(from: forecast)))
        } catch let error {
            return then(.failure(error))
        }
    }

    private func calculateFiveDays(from items: [Forecast]) -> [Forecast] {
        return
            stride(from: 0, to: items.count, by: 8)
           .reduce([Forecast]()) { (acc, index) in acc + [items[index]] }
           .prefix(5)
           |> Array.init
    }
}

enum ParsinError: Error {
    case decodingError
}
