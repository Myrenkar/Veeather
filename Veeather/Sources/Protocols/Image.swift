import UIKit

// Abstract protocol to make image platform agnostic
protocol Image {}

extension UIImage: Image {}


protocol ImageView: AnyObject {
    var originalImage: Image? { get set }
}

extension UIImageView: ImageView {
    var originalImage: Image? {
        get {
            return self.image
        }
        set {
            self.image = newValue as? UIImage
        }
    }
}
