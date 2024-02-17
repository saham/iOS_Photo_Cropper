import UIKit

extension UIView {
    var isCircle:Bool {
        get {
            return frame.size.width == frame.height  && self.layer.cornerRadius == frame.width / 2
        }
        set {
            guard frame.size.width == frame.height else {return}
            self.layer.cornerRadius = newValue ? frame.width / 2 : 0
        }
    }
}
