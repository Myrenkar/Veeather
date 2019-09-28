import UIKit
import Networking

protocol ImageProviding {
    func image(for url: URL, then: @escaping ((Result<Image?, Error>) -> Void))
}

final class ImageProvider: ImageProviding {

    // MARK: - Properties

    private let urlSession: URLSession

    // MARK: - Init

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    // MARK: - ImageProviding

    func image(for url: URL, then: @escaping ((Result<Image?, Error>) -> Void)) {
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad

        let task = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                then(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...300:
                    if let data = data {
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

}
