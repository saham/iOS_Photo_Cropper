import UIKit

class ProfileViewController: UIViewController {
   
    // MARK: - Variables
    var user:User?
   
    // MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var membershipLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var premiumButton: UIButton!
    // MARK: - Actions
    @IBAction func editProfilePressed(_ sender: UIButton) {
        let storyboard  = StoryboardFactory.Main
        if let NVC = storyboard.instantiateViewController(withIdentifier: AppConstant.ViewControllerID.cropNV) as? UINavigationController,
           let DVC = NVC.topViewController as? CropViewController {
            NVC.modalPresentationStyle = .fullScreen
            DVC.originalImage = profileImageView.image
            present(NVC, animated: true)
        }
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        let storyboard  = StoryboardFactory.Main
        if let DVC = storyboard.instantiateViewController(withIdentifier: AppConstant.ViewControllerID.addPhoto) as? PhotoSelectorViewController {
            DVC.currentImage = profileImageView.image
            self.navigationController?.pushViewController(DVC, animated: true)
        }
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        user = getUser()
        setUserInfo(user: user)
        setupUI()
    }
    
    // MARK: - UI
    func setupUI() {
        profileImageView.isCircle = true
        premiumButton.backgroundColor = .buttonLightBlue
        premiumButton.setTitleColor(.buttonDarkBlue, for: [])
        premiumButton.layer.cornerRadius = AppConstant.Number.cornerRadius
        premiumButton.titleLabel?.font = .CustomFont(weight: .regular, size: 12)
        premiumButton.clipsToBounds = true
        editProfileButton.layer.borderWidth = AppConstant.Number.borderWidth
        editProfileButton.layer.borderColor = UIColor.buttonBorderGray.cgColor
        editProfileButton.layer.cornerRadius = AppConstant.Number.cornerRadius
        editProfileButton.setTitleColor(.textBlack, for: [])
        nameLabel.font = .CustomFont(fontFamily: .Inter, weight: .bold, size: 18)
        nameLabel.textColor = .nameBlack
        jobLabel.font = .CustomFont(weight: .regular, size: 14)
        jobLabel.textColor = .nameBlack
        membershipLabel.font = .CustomFont(weight: .light, size: 14)
        membershipLabel.textColor = .textBlack
        membershipLabel.isCircle = true
        membershipLabel.backgroundColor = .backgroundGray
        membershipLabel.clipsToBounds = true
        membershipLabel.layer.borderColor = UIColor.borderGray.cgColor
        membershipLabel.layer.borderWidth = AppConstant.Number.borderWidth
        locationLabel.font = .CustomFont(weight: .light, size: 14)
        locationLabel.textColor = .nameBlack
        phoneLabel.font = .CustomFont(weight: .light, size: 14)
        phoneLabel.textColor = .nameBlack
    }
    
    // MARK: - Set user
    func setUserInfo(user u:User?) {
        guard let user = u else {return}
        profileImageView.image = UIImage(named: user.profile)
        nameLabel.text = user.name
        jobLabel.text = user.job
        membershipLabel.text = user.membership
        locationLabel.text = "Location " + (user.location ?? "N/A")
        phoneLabel.text = user.phone
    }
    
    // MARK: - Fetch User
    func getUser() -> User? {
        if let path = Bundle.main.path(forResource: "User", ofType: "json"), let data = NSData(contentsOfFile: path) as Data? {
            do {
                return try? JSONDecoder().decode(User.self, from: data)
            }
        }
        return nil
    }
}
