import UIKit
import BackgroundRemoval

class ProgressViewController: UIViewController {
    
    // MARK: - Variables
    var imageToUpload: UIImage?
    var timer = Timer()
    var progressValue = 0
    var removeBackground = false
    
    // MARK: - Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressSlider: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI
    func setupUI() {
        titleLabel.textColor = .textBlack
        titleLabel.font = .CustomFont(weight: .bold, size: 18)
        titleLabel.text = "Take a sip.."
        progressImageView.isCircle = true
        progressLabel.text = ""
        progressSlider.setProgress(0.0, animated: false)
        progressLabel.textColor = .textBlack
        progressLabel.font = .CustomFont(weight: .medium, size: 14)
        statusLabel.text = AppConstant.Texts.progress
        statusLabel.textColor = .textBlack
        statusLabel.font = .CustomFont(weight: .medium, size: 14)
        timer = Timer.scheduledTimer(timeInterval:0.01, target:self, selector:#selector(timerProgress), userInfo: nil, repeats: true)
        progressImageView.image = imageToUpload
    }
    
    // MARK: - Timer
    @objc func timerProgress() {
        /* Just to simulate network delay in removing background
        It takes 1 seconds then background is removed
         */
        progressValue += 1
        if progressValue == 100 {
            timer.invalidate()
            if removeBackground,let image = imageToUpload {
                progressImageView.image = try? BackgroundRemoval.init().removeBackground(image: image)
            }
        }
        DispatchQueue.main.async {
            self.progressLabel.text = "% \(self.progressValue) processed..."
            self.progressSlider.setProgress(Float(self.progressValue), animated: true)
        }
    }
}
