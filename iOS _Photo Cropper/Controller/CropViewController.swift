import UIKit
import Foundation
import BackgroundRemoval
class CropViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var removeBackgroundLabel: UILabel!
    @IBOutlet weak var rotateButton: UIButton!
    @IBAction func sliderChanged(_ sender: UISlider) {
        circleHeight = CGFloat(sender.value)
        sampleMask.layer.mask = getMaskLayer()
    }
    @IBAction func uploadPressed(_ sender: UIButton) {
        let storyboard = StoryboardFactory.Main
        if let DVC = storyboard.instantiateViewController(withIdentifier: AppConstant.ViewControllerID.progress) as? ProgressViewController {
            DVC.imageToUpload = getCroppedImage(from: self.profileImageView.image)
            DVC.removeBackground = removeBackground
            navigationController?.pushViewController(DVC, animated: true)
        }
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        dismiss(animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func rotatePhoto(_ sender: UIButton) {
        self.profileImageView.image = self.profileImageView.image?.rotate(radians: .pi / 2)
    }
    
    
    @IBAction func removeBackgroundSwitch(_ sender: UISwitch) {
        removeBackground = sender.isOn
    }
    var circleHeight = CGFloat(300)
    var originalImage: UIImage?
    let sampleMask = UIView()
    var removeBackground = false
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.image = originalImage
        sampleMask.layer.mask = getMaskLayer()
        topView.backgroundColor = .backgroundGray
        topView.layer.cornerRadius = 8.0
        titleLabel.text = "Edit headshot"
        titleLabel.textColor = .titleBlack
        titleLabel.font = .CustomFont(weight: .semiBold, size: 18)
        radiusSlider.maximumTrackTintColor = .borderGray
        radiusSlider.minimumTrackTintColor = .themeBlue
        rotateButton.setTitleColor(.buttonBlack, for: [])
        uploadButton.backgroundColor = .buttonBlue
        uploadButton.setTitleColor(.white, for: [])
        uploadButton.titleLabel?.font = .CustomFont(weight: .semiBold, size: 16)
        uploadButton.setTitle("Upload headshot", for: [])
        uploadButton.layer.cornerRadius = 8.0
        cancelButton.layer.borderColor = UIColor.buttonBorderGray.cgColor
        cancelButton.layer.borderWidth = 1.0
        cancelButton.backgroundColor = .white
        cancelButton.setTitleColor(.textBlack, for: [])
        cancelButton.titleLabel?.font = .CustomFont(weight: .semiBold, size: 16)
        cancelButton.setTitle("Cancel", for: [])
        cancelButton.layer.cornerRadius = 8.0
    }

    func getPath(circleHeight: CGFloat = CGFloat(300))->UIBezierPath {
        let circleRect = CGRect(x:sampleMask.center.x - circleHeight / 2, y:sampleMask.center.y - circleHeight / 2, width: circleHeight, height: circleHeight)
        let circlePath = UIBezierPath(ovalIn: circleRect)
        return circlePath
    }
    
    func getMaskLayer()->CALayer {
        sampleMask.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: view.frame.width))
        sampleMask.backgroundColor =  UIColor.black.withAlphaComponent(0.6)
        self.profileImageView.addSubview(sampleMask)
        let maskLayer = CALayer()
        let circleLayer = CAShapeLayer()
        let finalPath = UIBezierPath(roundedRect: CGRect(x:0 , y:0, width: sampleMask.frame.size.width,height: sampleMask.frame.size.height), cornerRadius: 0)
        maskLayer.frame = sampleMask.bounds
        circleLayer.frame = CGRect(x:0 , y:0, width: sampleMask.frame.size.width,height: sampleMask.frame.size.height)
        let circlePath = getPath(circleHeight: circleHeight)
        finalPath.append(circlePath.reversing())
        circleLayer.path = finalPath.cgPath
        circleLayer.borderColor = UIColor.white.withAlphaComponent(1).cgColor
        circleLayer.borderWidth = 1
        maskLayer.addSublayer(circleLayer)
        return maskLayer
    }
    func getCroppedImage(from image:UIImage?)->UIImage? {
        let cropRect = CGRect(x:sampleMask.center.x - circleHeight / 2, y:sampleMask.center.y - circleHeight / 2, width: circleHeight, height: circleHeight)
        if let croppedCGImage = profileImageView.image?.cgImage?.cropping(to: cropRect){
            return UIImage(cgImage: croppedCGImage)
        }
        return nil
    }
}
