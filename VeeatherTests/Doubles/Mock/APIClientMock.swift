@testable import Veeather
import Networking

final class APIClientMock: APIClient {
    var successResult: Result<APIResponse, Error>?
    var errorResult: Result<APIResponse, Error>?
    func perform(request: APIRequest, then: @escaping ((Result<APIResponse, Error>) -> Void)) {
        if successResult != nil {
            then(successResult!)
        } else if errorResult != nil {
            then(errorResult!)
        }
    }
}
