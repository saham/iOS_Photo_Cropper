import Foundation
import UIKit
extension UIColor {
    public convenience init(hex: String) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            if hexColor.count == 6 { // no alpha
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x000000ff) / 255
                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            } else if hexColor.count == 8 { // with alpha
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
        return
    }
    static var nameBlack: UIColor {
        return UIColor(hex: "#27272A")
    }
    static var textBlack: UIColor {
        return UIColor(hex: "#344054")
    }
    static var borderGray: UIColor {
        return UIColor(hex: "#EAECF0")
    }
    static var backgroundGray: UIColor {
        return UIColor(hex: "#F9FAFB")
    }
    static var titleBlack: UIColor {
        return UIColor(hex: "#101828")
    }
    static var themeBlue: UIColor {
        return UIColor(hex: "#326DF7")
    }
    static var buttonBlack: UIColor {
        return UIColor(hex: "#475467")
    }
    static var buttonBlue: UIColor {
        return UIColor(hex: "#155EEF")
    }
    static var buttonBorderGray: UIColor {
        return UIColor(hex: "#D0D5DD")
    }
}
