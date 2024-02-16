import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var membershipLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBAction func editProfilePressed(_ sender: UIButton) {
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        if let NVC = storyboard.instantiateViewController(withIdentifier: "CropNVC") as? UINavigationController,
           let DVC = NVC.topViewController as? CropViewController {
            NVC.modalPresentationStyle = .fullScreen
            DVC.originalImage = profileImageView.image
            present(NVC, animated: true)
        }
    }
    @IBAction func addPressed(_ sender: UIButton) {
    
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        if let DVC = storyboard.instantiateViewController(withIdentifier: "AddPhotoVC") as? PhotoSelectorViewController {
            DVC.currentImage = profileImageView.image
            self.navigationController?.pushViewController(DVC, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.image = UIImage(named: "profileImage")
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        editProfileButton.layer.borderWidth = 1.0
        editProfileButton.layer.borderColor = UIColor.buttonBorderGray.cgColor
        editProfileButton.layer.cornerRadius = 10.0
        editProfileButton.setTitleColor(.textBlack, for: [])
        nameLabel.font = .CustomFont(fontFamily: .Inter, weight: .bold, size: 18)
        nameLabel.textColor = .nameBlack
        jobLabel.font = .CustomFont(weight: .regular, size: 14)
        jobLabel.textColor = .nameBlack
        membershipLabel.font = .CustomFont(weight: .light, size: 14)
        membershipLabel.textColor = .textBlack
        membershipLabel.layer.cornerRadius = jobLabel.frame.size.height / 2
        membershipLabel.backgroundColor = .backgroundGray
        membershipLabel.layer.borderColor = UIColor.borderGray.cgColor
        membershipLabel.layer.borderWidth = 2.0
        locationLabel.font = .CustomFont(weight: .light, size: 14)
        locationLabel.textColor = .nameBlack
        phoneLabel.font = .CustomFont(weight: .light, size: 14)
        phoneLabel.textColor = .nameBlack
        
    }

}
