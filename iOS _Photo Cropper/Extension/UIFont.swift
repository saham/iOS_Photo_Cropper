import Foundation
import UIKit

extension UIFont {
   class func CustomFont(fontFamily family:FontFamily = .Inter, weight w:FontWeight, size s:CGFloat) -> UIFont {
        let FontName = family.rawValue + "-" + w.rawValue
        return UIFont(name: FontName, size: s) ?? UIFont.systemFont(ofSize: 12)
    }
}

enum FontFamily:String {
    case  Inter = "Inter"
}

enum FontWeight:String {
    case black = "Black"
    case bold = "bold"
    case extraBold = "ExtraBold"
    case extraLight = "ExtraLight"
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    case semiBold = "SemiBold"
    case thin = "Thin"
}
