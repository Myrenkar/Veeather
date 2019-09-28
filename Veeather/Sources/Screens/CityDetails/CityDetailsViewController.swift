import UIKit

final class CityDetailsViewController: ViewController {

    private lazy var customView = CityDetailsView()
    private let viewModel: CityDetailsViewModelProtocol
    private var disposal = Disposal()

    init(viewModel: CityDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = customView
    }

    override func setupBindings() {
        super.setupBindings()
        viewModel.information.observe(DispatchQueue.main) { [weak self] newData, _ in
            self?.customView.dateLabel.text = newData
        }.add(to: &disposal)
    }

    override func setupProperties() {
        super.setupProperties()

        title = viewModel.title
    }
}
