@testable import Veeather

import XCTest
import SnapshotTesting

final class VeeatherUITests: XCTestCase {
    var window: UIWindow!
    var serviceMock: ForecastServiceMock!
    var iconProviderMock: IconProviderMock!

    override func setUp() {
        super.setUp()
        record = true

        window = UIWindow()
        serviceMock = ForecastServiceMock()
        iconProviderMock = IconProviderMock()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    func testEmptyState() {
        let cityViewController = CityViewController(viewModel: CityViewModel(service: serviceMock), iconProvider: iconProviderMock)
        cityViewController.viewDidLoad()

        assertSnapshot(matching: cityViewController,
                       as: .image)


    }

}
