import Foundation

typealias NetworkResponse = ((Result<APIResponse, Error>) -> Void)

public final class DefaultAPIClient: APIClient {

    // MARK: Properties
    
    private let session: URLSession
    private let cache: URLCache
    
    // MARK: Initializers
    
    public init(session: URLSession = .shared, cache: URLCache = .shared) {
        self.session = session
        self.cache = cache
    }

    // MARK: APIClient

    public func perform(request: APIRequest, then: @escaping ((Result<APIResponse, Error>) -> Void)) {
        send(request: request, then: then)
    }
    
    // MARK: Private

    private func send(request: APIRequest, then: @escaping NetworkResponse) {
        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest(request: request)
            urlRequest.cachePolicy = .returnCacheDataElseLoad
        } catch let error {
            then(.failure(error))
            return
        }

        if retrieveCache(urlRequest: urlRequest, then: then) {
            return
        }

        let task = self.session.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let error = error {
                if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    then(.failure(APIError.internetConnectionUnavailable))
                } else {
                    then(.failure(error))
                }
            }

            guard let response = response as? HTTPURLResponse else {
                then(.failure(APIError.noResponse))
                return
            }
            if 200..<300 ~= response.statusCode {
                self?.cache(data: data, response: response, urlRequest: urlRequest)
                then(.success(APIResponse(data: data, response: response)))
            } else {
                then(.failure(APIError.unexpectedStatusCode(statusCode: response.statusCode)))
            }
        }
        task.resume()
    }

    private func cache(data: Data?, response: URLResponse?, urlRequest: URLRequest) {
        guard let response = response, let data = data else { return }
        let cachedData = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedData, for: urlRequest)
    }

    private func retrieveCache(urlRequest: URLRequest, then: @escaping NetworkResponse) -> Bool {
        if let cachedData = cache.cachedResponse(for: urlRequest), let response = cachedData.response as? HTTPURLResponse {
            then(.success(APIResponse(data: cachedData.data, response: response)))
            return true
        }
        return false
    }
}
