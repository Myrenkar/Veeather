import Foundation

private class PrivateToken {}

extension Decodable {
    static func decodingResource(byName resourceName: String) -> Self {
        guard let resourceURL = Bundle(for: PrivateToken.self).url(forResource: resourceName, withExtension: "json") else {
            fatalError("Could not find resource '\(resourceName)'")
        }
        guard let resourceData = try? Data(contentsOf: resourceURL) else {
            fatalError("Could not load resource '\(resourceURL)'")
        }
        do {
            return try Self.decodeJson(resourceData)
        } catch {
            fatalError("Could not decode resource '\(resourceURL)': \(error)")
        }
    }

    public static func decodeJson(_ jsonData: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: jsonData)
    }
}
