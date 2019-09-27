import UIKit

final class ApplicationController {

    // MARK: Properties

    private let dependencies: ApplicationDependenciesProvider

    // MARK: Initialization

    init(dependencies: ApplicationDependenciesProvider) {
        self.dependencies = dependencies
    }

    // MARK: RootViewController

    private(set) lazy var rootViewController: UINavigationController = {
        let viewController = self.dependencies.weatherFactory.buildCityViewController()
        let flowController = WeatherFlowController(viewController: viewController)
        return flowController.rootViewController
    }()

    func configureCache() {
        URLCache.shared = URLCache(memoryCapacity: 50 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: nil)
    }
    
}
