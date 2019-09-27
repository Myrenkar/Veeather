import UIKit

protocol CityViewControllerDelegate: AnyObject {
    func didTapCity()
}

final class CityViewController: TableViewController {
    weak var delegate: CityViewControllerDelegate?
}

extension CityViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapCity()
    }
}
