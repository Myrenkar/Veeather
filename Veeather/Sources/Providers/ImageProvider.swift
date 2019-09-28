import UIKit
import Networking

typealias ImageResponse = ((Result<Image?, Error>) -> Void)

protocol ImageProviding {
    func image(for url: URL, then: @escaping ImageResponse)
}

final class ImageProvider: ImageProviding {

    // MARK: - Properties

    private let urlSession: URLSession
    private let cache: URLCache

    // MARK: - Init

    init(urlSession: URLSession = .shared, cache: URLCache = .shared) {
        self.urlSession = urlSession
        self.cache = cache
    }

    // MARK: - ImageProviding

    func image(for url: URL, then: @escaping ImageResponse) {
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad

        if retrieveCache(urlRequest: request, then: then) {
            return
        }

        let task = urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                then(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...300:
                    if let data = data {
                        self?.cache(data: data, response: response, urlRequest: request)
                        then(.success(UIImage(data: data)))
                    } else {
                        then(.failure(APIError.noResponse))
                    }
                default:
                    then(.failure(APIError.unexpectedStatusCode(statusCode: httpResponse.statusCode)))
                }
            } else {
                then(.failure(APIError.noResponse))
            }
        }
        task.resume()
    }

    private func cache(data: Data?, response: URLResponse?, urlRequest: URLRequest) {
        guard let response = response, let data = data else { return }
        let cachedData = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedData, for: urlRequest)
    }

    private func retrieveCache(urlRequest: URLRequest, then: @escaping ImageResponse) -> Bool {
        if let cachedData = cache.cachedResponse(for: urlRequest){
            then(.success(UIImage(data: cachedData.data)))
            return true
        }
        return false
    }
}
