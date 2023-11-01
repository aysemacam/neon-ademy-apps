//
//  ViewController.swift
//  MathSolver


import UIKit
import NeonSDK
import SnapKit
import CropViewController

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeViews()
    }
    
    func setupHomeViews() {
        view.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.text = AppStrings.title
        titleLabel.font = Font.custom(size: 34, fontWeight: .Bold)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(67)
            make.left.equalToSuperview().offset(89)
            make.right.equalToSuperview().inset(89)
        }
        
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(named: AppStrings.settings), for: .normal)
        view.addSubview(settingsButton)
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(62)
            make.right.equalToSuperview().inset(6)
        }
        
        let subTitleLabel = UILabel()
        subTitleLabel.text = AppStrings.subTitle
        subTitleLabel.font = Font.custom(size: 34, fontWeight: .Bold)
        view.addSubview(subTitleLabel)

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(273)
            make.left.equalToSuperview().offset(106)
            make.right.equalToSuperview().inset(106)
        }
        
        let textLabel = UILabel()
        textLabel.text = AppStrings.homeTextLabel
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(20)
        }

        let getImageButton = UIButton()
        getImageButton.setImage(UIImage(named: AppStrings.getImg), for: .normal)
        getImageButton.imageView?.contentMode = .scaleAspectFit
        getImageButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)

        view.addSubview(getImageButton)
        
        getImageButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(148)
            make.right.equalToSuperview().inset(148)
            make.bottom.equalToSuperview().inset(63)
        }
        
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(named: AppStrings.imgArrow)
        view.addSubview(arrowImage)
        
        arrowImage.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(42)
            make.centerX.equalToSuperview()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        picker.dismiss(animated: true, completion: nil)
        showCrop(image: image )
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func showActionSheet() {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
        actionSheet.addAction(UIAlertAction(title: AppStrings.actionTitle1, style: .default, handler: { [weak self] _ in
                self?.openCamera()
            }))
            
        actionSheet.addAction(UIAlertAction(title: AppStrings.actionTitle2, style: .default, handler: { [weak self] _ in
                self?.openGallery()
            }))
    
        actionSheet.addAction(UIAlertAction(title: AppStrings.cancel, style: .cancel, handler: nil))
            self.present(actionSheet, animated: true, completion: nil)
        }
        
        func openCamera() {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func showCrop(image: UIImage) {
        let vc = CropViewController(croppingStyle: .default, image: image)
        vc.aspectRatioPreset = .presetSquare
        vc.aspectRatioLockEnabled = false
        vc.toolbarPosition = .bottom
        vc.doneButtonTitle = AppStrings.next
        vc.cancelButtonTitle = AppStrings.cancel
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true)
    }

    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        DispatchQueue.main.async {
            ApiService.shared.sendImageToMathpix(image: image) { [weak self] result in
                cropViewController.dismiss(animated: true) {
                    if let latexResult = result {
                        print("Success: \(latexResult)")
                        let solutionVC = SolutionViewController()
                        solutionVC.modalPresentationStyle = .fullScreen
                        solutionVC.latexResult = latexResult
                        self!.present(solutionVC, animated: true)
                    } else {
                        print("Error: Could not fetch data")
                    }
                }
            }
        }
    }
}
