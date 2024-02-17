import UIKit
import AVFoundation

class PhotoSelectorViewController: UIViewController {
    
    // MARK: -  Variables
    var viewModel: [UIImage?] = []
    var currentImage:UIImage?
    
    // MARK: - Outlet
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.append(currentImage)
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action:  #selector(backPressed))
        self.navigationItem.leftBarButtonItem  = backButton
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CollectionView
extension PhotoSelectorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstant.Cell.camera, for: indexPath) as! CameraCollectionViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstant.Cell.image, for: indexPath) as! ImageCollectionViewCell
            cell.userImageView.image = viewModel[indexPath.row - 1]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row > 0 else {return}
        // Headshot Editor Screen does not have Back Button. Navigation is done modally
        let storyboard  = StoryboardFactory.Main
        if let NVC = storyboard.instantiateViewController(withIdentifier: AppConstant.ViewControllerID.cropNV) as? UINavigationController,
           let DVC = NVC.topViewController as? CropViewController {
            NVC.modalPresentationStyle = .fullScreen
            DVC.originalImage = viewModel[indexPath.row - 1]
            present(NVC, animated: true)
        }
    }
}

extension PhotoSelectorViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.size.width / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

// MARK: - Delegate
extension PhotoSelectorViewController: cameraDelegate {
    func cameraButtonPressed() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    }
}
// MARK: - Image Picker
extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            viewModel.append(image)
        } else if let image = info[.originalImage] as? UIImage {
            viewModel.append(image)
        }
        photoCollectionView.reloadData()
        self.dismiss(animated: true)
    }
}

