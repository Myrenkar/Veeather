@testable import Veeather

import XCTest
import SnapshotTesting

final class VeeatherUITests: XCTestCase {
    var serviceMock: ForecastServiceMock!
    var iconProviderMock: IconProviderMock!

    override func setUp() {
        super.setUp()

        serviceMock = ForecastServiceMock()
        iconProviderMock = IconProviderMock()
    }

    override func tearDown() {
        serviceMock = nil
        iconProviderMock = nil
        super.tearDown()
    }

    func testEmptyState() {
        let cityViewController = CityViewController(viewModel: CityViewModel(service: serviceMock), iconProvider: iconProviderMock)
        cityViewController.viewDidLoad()

        assertSnapshot(matching: cityViewController, as: .image, record: true)
    }

}
