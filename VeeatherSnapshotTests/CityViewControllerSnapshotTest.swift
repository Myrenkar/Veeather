@testable import Veeather

import XCTest
import SnapshotTesting

final class CityViewControllerSnapshotTest: XCTestCase {
    var serviceMock: ForecastServiceMock!
    var iconProviderMock: IconProviderMock!
    var window: UIWindow!

    override func setUp() {
        super.setUp()

        serviceMock = ForecastServiceMock()
        iconProviderMock = IconProviderMock()
        window = UIWindow()
    }

    override func tearDown() {
        serviceMock = nil
        iconProviderMock = nil
        window = nil
        super.tearDown()
    }

    func testFilledState() {
        serviceMock.result = .success(Forecast.fixture())
        iconProviderMock.result = .success(UIImage.getImageWithColor(color: .white, size: CGSize(width: 40, height: 40)))
        let cityViewController = CityViewController(viewModel: CityViewModel(service: serviceMock), iconProvider: iconProviderMock)
        cityViewController.viewDidLoad()
        let parent = snapshotTestsControllers(child: cityViewController).parent
        loadView(parent, in: window)
        assertSnapshot(matching: cityViewController, as: .image)
    }

    func testEmptyState() {
        serviceMock.result = .success([])
        iconProviderMock.result = .failure(SnapshotError.sample)
        let cityViewController = CityViewController(viewModel: CityViewModel(service: serviceMock), iconProvider: iconProviderMock)
        cityViewController.viewDidLoad()
        let parent = snapshotTestsControllers(child: cityViewController).parent
        loadView(parent, in: window)
        assertSnapshot(matching: cityViewController, as: .image)

    }
}

private enum SnapshotError: Error {
    case sample
}
