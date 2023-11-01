//
//  OnBoardingVC.swift
//  MathSolver


import UIKit
import SnapKit
import NeonSDK

class OnBoardingVC: UIViewController {
    let imageArray: [String] = [AppStrings.imgPlusWhite, AppStrings.imgOnboarding2, AppStrings.imgOnboarding3, AppStrings.imgOnboarding4]
    let textArray: [String] = [AppStrings.oBText1, AppStrings.oBText2, AppStrings.oBText3, AppStrings.oBText4]
    let titleArray: [String] = [AppStrings.oBTitle1, AppStrings.oBTitle2, AppStrings.oBTitle3, AppStrings.oBTitle4]
    
    var currentImageIndex: Int = 0
    let oBImageView = UIImageView()
    let backgroundImage = UIImageView()
    let pageControl = NeonPageControlV1()
    let oBText = UILabel()
    var oBTitleLabelBottomConstraint: Constraint?
    let oBTitleLabel = UILabel()
    let continueButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        backgroundImage.image = UIImage(named: AppStrings.imgOnboarding1)
        view.addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        oBImageView.image = UIImage(named: AppStrings.imgPlusWhite)
        view.addSubview(oBImageView)
        oBImageView.snp.makeConstraints { make in
            make.centerY.equalTo(330)
            make.centerX.equalToSuperview()
        }
        
        let continueButton = UIButton()
        continueButton.setTitle(AppStrings.next, for: .normal)
        continueButton.layer.cornerRadius = 30
        continueButton.layer.masksToBounds = true
        continueButton.backgroundColor = UIColor(named: AppStrings.buttonBackgroundColor)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(65)
        }
        
        pageControl.numberOfPages = 3
        pageControl.radius = 3
        pageControl.currentPageTintColor = .black
        pageControl.tintColor = .white
        pageControl.padding = 6
        view.addSubview(pageControl)
        pageControl.isHidden = true
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(continueButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    
        oBText.text = textArray[0]
        oBText.numberOfLines = 0
        oBText.textAlignment = .center
        oBText.font = Font.custom(size: 17, fontWeight: .Regular)
        view.addSubview(oBText)
        oBText.font = Font.custom(size: 15, fontWeight: .Medium)
        view.addSubview(oBText)
        oBText.isHidden = true
        
        oBText.snp.makeConstraints { make in
            make.bottom.equalTo(pageControl.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }
        
        oBTitleLabel.text = AppStrings.oBTitle1
        oBTitleLabel.text = AppStrings.oBTitle1
        oBTitleLabel.numberOfLines = 0
        oBTitleLabel.font = Font.custom(size: 34, fontWeight: .Bold)
        view.addSubview(oBTitleLabel)
        
        oBTitleLabel.snp.makeConstraints { make in
            oBTitleLabelBottomConstraint = make.bottom.equalTo(continueButton.snp.top).offset(-10).constraint
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func continueButtonTapped() {
        updateUIBasedOnIndex()
    }

    func updateUIBasedOnIndex() {
        currentImageIndex = (currentImageIndex + 1) % imageArray.count
        oBImageView.image = UIImage(named: imageArray[currentImageIndex])
        oBTitleLabel.text = titleArray[currentImageIndex]
        oBText.text = textArray[currentImageIndex]
        if currentImageIndex == 0 {
            oBText.isHidden = true
            pageControl.isHidden = true
            oBTitleLabelBottomConstraint?.update(offset: -10)
            backgroundImage.image = UIImage(named: AppStrings.imgOnboarding1)
        } else if currentImageIndex == 3 {
            let vc = PaywallVC()
            vc.modalPresentationStyle = .fullScreen
           present(vc, animated: true)
        } else {
            oBText.isHidden = false
            pageControl.isHidden = false
            oBTitleLabelBottomConstraint?.update(offset: -90)
            backgroundImage.image = UIImage(named: AppStrings.onboardingBackground)
        }
    }
}
