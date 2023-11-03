//
//  SolutionView.swift
//  MathSolver


import Foundation
import UIKit
import SnapKit
import WebKit
import NeonSDK

class SolutionContentView: UIView {
    
    let textLabel = UILabel()
    let webView = WKWebView()
    let plusImageView = UIImageView()
    let titleLabel = UILabel()
    let resultButton = UIButton()
    var webViewHeightConstraint: Constraint?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 30
        
        self.addSubview(titleLabel)
        titleLabel.text = "Solved"
        titleLabel.isHidden = true
        titleLabel.textAlignment = .center
        titleLabel.font = Font.custom(size: 22, fontWeight: .Bold)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(40)
        }
        
        webView.backgroundColor = .clear
        self.addSubview(webView)

        webView.snp.makeConstraints { make in
              make.top.equalToSuperview().offset(50)
              make.right.equalToSuperview().inset(17)
              make.left.equalToSuperview().offset(17)
            webViewHeightConstraint = make.height.equalToSuperview().multipliedBy(0.45).constraint
          }
        
        textLabel.text = "Solving..."
        textLabel.textAlignment = .center
        textLabel.font = Font.custom(size: 22, fontWeight: .Bold)
        self.addSubview(textLabel)

        textLabel.snp.makeConstraints { make in
             make.top.equalTo(webView.snp.bottom).offset(7)
             make.left.right.equalToSuperview()
         }
        
        resultButton.backgroundColor = .blue
        resultButton.isHidden = true
        resultButton.setTitle("show result steps", for: .normal)
        resultButton.layer.cornerRadius = 30
        self.addSubview(resultButton)
        
        resultButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(14)
            make.left.equalToSuperview().offset(37)
            make.right.equalToSuperview().inset(37)
            make.height.equalTo(60)
        }
            
        plusImageView.image = UIImage(named: AppStrings.plusImage)
        plusImageView.isHidden = false
        plusImageView.layer.shadowColor = UIColor.black.cgColor
        plusImageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        plusImageView.layer.shadowRadius = 5
        plusImageView.layer.shadowOpacity = 0.4
        self.addSubview(plusImageView)
        
        plusImageView.snp.makeConstraints { make in
           make.bottom.equalTo(self.snp.top).offset(50)
           make.centerX.equalToSuperview()
        }
    }
    func updateUI() {
        webView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(87)
            make.right.equalToSuperview().inset(17)
            make.left.equalToSuperview().offset(17)
            make.height.equalToSuperview().multipliedBy(0.21)
        }

        textLabel.snp.remakeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(52)
            make.left.equalToSuperview().offset(37)
            make.right.equalToSuperview().inset(37)

        }

        plusImageView.isHidden = true
        titleLabel.isHidden = false
        textLabel.textAlignment = .left
        textLabel.font = Font.custom(size: 32, fontWeight: .Medium)
        resultButton.isHidden = false
        self.bringSubviewToFront(titleLabel)
    }
}
