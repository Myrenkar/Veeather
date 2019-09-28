import UIKit

protocol CityViewControllerDelegate: AnyObject {
    func didTapCity(forecast: Forecast)
}

final class CityViewController: TableViewController {
    private let viewModel: CityViewModelProtocol
    private let iconProvider: IconProviding
    private var disposal = Disposal()
    private var foreCasts = [Forecast]() {
        didSet {
            refreshControl?.endRefreshing()
            tableView.reloadData()
        }
    }

    weak var delegate: CityViewControllerDelegate?

    init(viewModel: CityViewModelProtocol, iconProvider: IconProviding) {
        self.viewModel = viewModel
        self.iconProvider = iconProvider
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refresh()
    }

    override func setupProperties() {
        super.setupProperties()
        tableView.registerClass(CityCell.self)
        setupRefreshControl()
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.forecasts.observe(DispatchQueue.main) { [weak self] newData, _ in
            self?.foreCasts = newData
        }.add(to: &disposal)

        viewModel.error.observe { (error, _) in
            print(error?.localizedDescription ?? "xdd")
        }.add(to: &disposal)
    }
}

extension CityViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foreCasts.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapCity(forecast: foreCasts[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityCell = tableView.dequeue()
        let cellViewModel = CityCellViewModel(forecast: foreCasts[indexPath.row], iconProvider: iconProvider)
        cell.dateLabel.text = cellViewModel.time
        cell.temperatureLabel.text = cellViewModel.temperature
        cellViewModel.setImage(for: cell.iconImageView)
        return cell
    }
}

private extension CityViewController {
    func setupRefreshControl() {
        let control = UIRefreshControl(frame: .zero)
        control.tintColor = .red
        control.addTarget(self, action: #selector(refreh), for: .valueChanged)
        refreshControl = control
    }

    @objc func refreh() {
        viewModel.refresh()
    }
}
