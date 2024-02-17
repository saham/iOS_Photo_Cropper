import UIKit

protocol cameraDelegate {
    func cameraButtonPressed()
}
class CameraCollectionViewCell: UICollectionViewCell {
    var delegate:cameraDelegate?
    @IBAction func cameraPressed(_ sender: UIButton) {
        delegate?.cameraButtonPressed()
    }
    
}
