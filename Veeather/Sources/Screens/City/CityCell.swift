import UIKit

final class CityCell: TableViewCell {
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()

        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override func setupProperties() {
        super.setupProperties()
        backgroundColor = .white
    }

    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        contentView.addSubview(temperatureLabel)
    }

    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()

        temperatureLabel.constrainEdges(to: self, insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 36))
    }
}
