import XCTest
@testable import Veeather

final class IconProviderMock: IconProviding {
    var result: (Result<Image?, Error>)?
    var methodWasCalled = false

    func getIcon(id: String, scale: Int, then: @escaping ImageResponse) {
        methodWasCalled = true
        then(result!)
    }
}
