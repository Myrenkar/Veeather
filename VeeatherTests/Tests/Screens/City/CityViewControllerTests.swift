import XCTest
@testable import Veeather

final class CityViewControllerTests: XCTestCase {

    var sut: CityViewController!
    var serviceMock: ForecastServiceMock!
    var viewModel: CityViewModel!
    var iconProviderMock: IconProviderMock!
    var delegateMock: CityViewControllerDelegateMock!

    override func setUp() {
        super.setUp()
        serviceMock = ForecastServiceMock()
        viewModel = CityViewModel(service: serviceMock)
        iconProviderMock = IconProviderMock()
        delegateMock = CityViewControllerDelegateMock()
        sut = CityViewController(viewModel: viewModel, iconProvider: iconProviderMock)
    }

    override func tearDown() {
        serviceMock = nil
        viewModel = nil
        iconProviderMock = nil
        delegateMock = nil
        sut = nil
        super.tearDown()
    }

    func testIfItemsWerePopulated() {
        // Arrange
        serviceMock.result = .success(Forecast.fixture())
        iconProviderMock.result = .success(UIImage.getImageWithColor(color: .red, size: CGSize(width: 40, height: 40)))

        // Act

        sut.viewDidLoad()
        viewModel.refresh()

        // Assert
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 40)
    }

    func testIfDelegateWasCalled() {
        // Arrange
        serviceMock.result = .success(Forecast.fixture())
        iconProviderMock.result = .success(UIImage.getImageWithColor(color: .red, size: CGSize(width: 40, height: 40)))
        sut.delegate = delegateMock

        // Act

        sut.viewDidLoad()
        viewModel.refresh()

        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 2, section: 0))

        // Assert
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 40)
        XCTAssertTrue(delegateMock.methodWasCalled)
        XCTAssertEqual(delegateMock.caputerdForecast!.weather.first!.information, "light snow")
    }
}

