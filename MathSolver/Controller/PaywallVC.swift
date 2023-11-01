//
//  PayWallVC.swift
//  MathSolver

import UIKit
import SnapKit
import NeonSDK

class PaywallVC: UIViewController {
    let stackComponent = PaywallStackView()
    let startButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPaywallViews()
    }
    
    func setupPaywallViews() {
        view.backgroundColor = .white
        
        let backgroundImg = UIImageView()
        backgroundImg.image = UIImage(named: AppStrings.onboardingBackground)
        view.addSubview(backgroundImg)
        backgroundImg.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        let paywallImg = UIImageView()
        paywallImg.image = UIImage(named: AppStrings.paywallImg)
        view.addSubview(paywallImg)
        paywallImg.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(95)
            make.right.equalToSuperview().offset(-125)
            make.left.equalToSuperview().offset(125)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = AppStrings.paywallTitle
        titleLabel.font = Font.custom(size: 30, fontWeight: .Bold)
        titleLabel.textColor = UIColor(named: AppStrings.buttonBackgroundColor)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(paywallImg.snp.bottom).offset(28)
            make.right.equalToSuperview().offset(-90)
            make.left.equalToSuperview().offset(90)
        }
        
        let featuresView = NeonPaywallFeaturesView()
        featuresView.featureTextColor = .black
        featuresView.featureIconBackgroundColor = .clear
        featuresView.featureIconTintColor = .black
        featuresView.addFeature(title: AppStrings.paywallText1, icon: UIImage(named: AppStrings.paywallIcon)!)
        featuresView.addFeature(title: AppStrings.paywallText2, icon: UIImage(named: AppStrings.paywallIcon)!)
        featuresView.addFeature(title: AppStrings.paywallText3, icon: UIImage(named: AppStrings.paywallIcon)!)
        view.addSubview(featuresView)
        featuresView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(80)
        }

             view.addSubview(stackComponent)
             stackComponent.snp.makeConstraints { make in
                 make.top.equalTo(featuresView.snp.bottom).offset(100)
                 make.left.equalToSuperview().offset(8)
                 make.right.equalToSuperview().inset(8)
             }
        startButton.layer.cornerRadius = 25
        startButton.setTitle(AppStrings.start, for: .normal)
        startButton.titleLabel?.font = Font.custom(size: 20, fontWeight: .Bold)
        startButton.backgroundColor = UIColor(named: AppStrings.buttonBackgroundColor)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(stackComponent.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(64)
        }
    }
    @objc func startButtonTapped() {
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}



