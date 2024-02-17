import Foundation
import UIKit
class StoryboardFactory: NSObject{
    static var Main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
