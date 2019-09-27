import UIKit

protocol FlowController {
    associatedtype RootViewController
    var rootViewController: RootViewController { get }
}

final class WeatherFlowController: FlowController {
    typealias RootViewController = UINavigationController

    private let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    var rootViewController: UINavigationController {
        return UINavigationController(rootViewController: viewController)
    }
}

extension WeatherFlowController: CityViewControllerDelegate {
    func didTapCity() {
        print("xddd")
    }
}
