import UIKit

protocol FlowController {
    associatedtype RootViewController
    var rootViewController: RootViewController { get }
}

final class WeatherFlowController: NSObject, FlowController {
    typealias RootViewController = UINavigationController

    private let factory: WeatherFactoryProtocol

    init(factory: WeatherFactoryProtocol) {
        self.factory = factory
        super.init()
    }

    lazy var rootViewController: UINavigationController = {
        let viewController = factory.buildCityViewController(delegate: self)
        return UINavigationController(rootViewController: viewController)
    }()
}

extension WeatherFlowController: CityViewControllerDelegate {
    func didTapCity(forecast: Forecast) {
        print(forecast.time)
    }
}
