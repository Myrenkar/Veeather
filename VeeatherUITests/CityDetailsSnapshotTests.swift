@testable import Veeather

import XCTest
import SnapshotTesting

final class CityDetailsSnapshotTests: XCTestCase {
    var forecast: Forecast!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        forecast = Forecast.fixture().first!
    }

    override func tearDown() {
        forecast = nil
        window = nil
        super.tearDown()
    }

    func testFilledState() {
        let cityDetailsViewModel = CityDetailsViewModel(forecast: forecast)
        let cityDetalsViewController = CityDetailsViewController(viewModel: cityDetailsViewModel)
        let parent = snapshotTestsControllers(child: cityDetalsViewController).parent
        loadView(parent, in: window)
        assertSnapshot(matching: cityDetalsViewController, as: .image)
    }
}
