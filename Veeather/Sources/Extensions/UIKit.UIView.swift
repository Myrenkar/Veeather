import UIKit

extension UIView {
    // Constraints
    func constrainEdges(to view: UIView, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
        ])
    }
}

// MARK: - Functional helpers 

func autolayoutStyle(_ view: UIView) -> Void {
  view.translatesAutoresizingMaskIntoConstraints = false
}

func roundedStyle(_ view: UIView) {
  view.clipsToBounds = true
  view.layer.cornerRadius = 6
}
