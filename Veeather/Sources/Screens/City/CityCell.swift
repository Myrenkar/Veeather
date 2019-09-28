import UIKit

final class CityCell: TableViewCell {

    // MARK: - Styles
    private lazy var labelStyle: (UILabel) -> Void =
        fontStyle(ofSize: 14, weight: .medium)
        <> textColorStyle(.black)
        <> roundedStyle

    private lazy var stackViewStyle: (UIStackView) -> Void =
      autolayoutStyle
        <> {
          $0.axis = .horizontal
          $0.spacing = 12
    }

    private lazy var imageViewStyle: (UIImageView) -> Void =
      autolayoutStyle
        <> {
            $0.contentMode = .scaleToFill
    }

    // MARK: - Subviews

    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        let style = labelStyle <> autolayoutStyle <> { $0.numberOfLines = 0 }
        style(label)
        return label
    }()

    private(set) lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        let style = labelStyle <> textColorStyle(.blue)
        style(label)
        return label
    }()

    private(set) lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        let style = imageViewStyle
        style(imageView)
        return imageView
    }()

    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [temperatureLabel,  iconImageView])
        let style = stackViewStyle
            <> {
                $0.axis = .vertical
                $0.spacing = 4
                $0.alignment = .center
        }
        style(stackView)
        return stackView
    }()

    override func setupProperties() {
        super.setupProperties()
        backgroundColor = .white
    }

    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [dateLabel, stackView].forEach(contentView.addSubview)
    }

    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),

            stackView.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // MARK: - Prepare for reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }
}
