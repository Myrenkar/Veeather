import UIKit

final class ApplicationController {

    // MARK: Properties

    private let flowController: WeatherFlowController

    // MARK: Initialization

    init(dependencies: ApplicationDependenciesProvider) {
        self.flowController =  WeatherFlowController(factory: dependencies.weatherFactory)
    }

    // MARK: RootViewController

    private(set) lazy var rootViewController: UINavigationController = {
        return flowController.rootViewController
    }()

    func configureCache() {
        URLCache.shared = URLCache(memoryCapacity: 50 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: nil)
    }

}
