import UIKit

protocol camera {
    func cameraButtonPressed()
}
class CameraCollectionViewCell: UICollectionViewCell {
    
    var delegate:camera?
    @IBAction func cameraPressed(_ sender: UIButton) {
        delegate?.cameraButtonPressed()
    }
    
}
