import Foundation

protocol IconProviding {
    func getIcon(id: String, scale: Int, then: @escaping ImageResponse)
}

final class IconProvider: IconProviding {
    private let imageProvider: ImageProviding

    init(imageProvider: ImageProviding) {
        self.imageProvider = imageProvider
    }

    func getIcon(id: String, scale: Int, then: @escaping ImageResponse) {
        let url = "http://openweathermap.org/img/wn/\(id)@\(scale)x.png"
            |> URL.init(string:)
        guard let unrwapped = url else {
            then(.failure(IconProviderError.badURL))
            return
        }
        imageProvider.image(for: unrwapped, then: then)
    }
}

enum IconProviderError: Error {
    case badURL
}
