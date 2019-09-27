import Foundation

public final class DefaultAPIClient: APIClient {

    // MARK: Properties
    
    private let session: URLSession
    
    // MARK: Initializers
    
    public init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: APIClient

    public func perform(request: APIRequest, then: @escaping ((Result<APIResponse, Error>) -> Void)) {
        send(request: request, then: then)
    }
    
    // MARK: Private

    private func send(request: APIRequest, then: @escaping ((Result<APIResponse, Error>) -> Void)) {
        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest(request: request)
        } catch let error {
            then(.failure(error))
            return
        }

        let task = self.session.dataTask(with: urlRequest) { data, response, error in
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
                then(.success(APIResponse(data: data, response: response)))
            } else {
                then(.failure(APIError.unexpectedStatusCode(statusCode: response.statusCode)))
            }
        }
        task.resume()
    }
}
