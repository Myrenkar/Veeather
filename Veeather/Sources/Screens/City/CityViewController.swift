import UIKit

protocol CityViewControllerDelegate: AnyObject {
    func didTapCity()
}

final class CityViewController: TableViewController {
    weak var delegate: CityViewControllerDelegate?
    private let viewModel: CityViewModelProtocol
    private var disposal = Disposal()
    private var foreCasts = [Forecast]() {
        didSet {
            tableView.reloadData()
        }
    }

    init(viewModel: CityViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refresh()
    }

    override func setupProperties() {
        super.setupProperties()
        tableView.registerClass(CityCell.self)
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
        delegate?.didTapCity()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentForecast = foreCasts[indexPath.row]
        let cell: CityCell = tableView.dequeue()
        cell.temperatureLabel.text = "\(currentForecast.main.humidity) \(currentForecast.main.tempMax)"
        return cell
    }
}
