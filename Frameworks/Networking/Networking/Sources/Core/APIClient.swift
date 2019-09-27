public protocol APIClient {
    
    /// Performs specific request
    ///
    /// - Parameters:
    ///   - request: APIRequest which needs to be performed
    ///   - then: completion with APIResponse, and error
    func perform(request: APIRequest, then: @escaping ((Result<APIResponse, Error>) -> Void))
}
