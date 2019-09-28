import Foundation

protocol KeysProtocol {
    static var apiToken: String { get }
}

final class Keys: KeysProtocol {
    static var apiToken: String {
        return VeeatherKeys().aPIToken
    }
}
