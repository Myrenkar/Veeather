import UIKit

final class CityDetailsView: View {

    // MARK: - Styles
    private lazy var labelStyle: (UILabel) -> Void =
        fontStyle(ofSize: 26, weight: .medium)
        <> textColorStyle(.black)
        <> autolayoutStyle

    // MARK: - Subviews

    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        let style = labelStyle <> { $0.numberOfLines = 0 }
        style(label)
        return label
    }()

    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        addSubview(dateLabel)
    }

    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()

        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
