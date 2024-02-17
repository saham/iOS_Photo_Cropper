import UIKit

extension UIFont {
   class func CustomFont(fontFamily family:FontFamily = .Inter, weight w:FontWeight, size s:CGFloat) -> UIFont {
        let FontName = family.rawValue + "-" + w.rawValue
        return UIFont(name: FontName, size: s) ?? UIFont.systemFont(ofSize: 12)
    }
}
