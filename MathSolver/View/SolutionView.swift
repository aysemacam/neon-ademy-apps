//
//  SolutionView.swift
//  MathSolver


import Foundation
import UIKit
import SnapKit
import WebKit
import NeonSDK

class SolutionContentView: UIView {
    
    let titleLabel = UILabel()
    let webView = WKWebView()
    let plusImageView = UIImageView()
    
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
        webView.backgroundColor = .clear
        self.addSubview(webView)

        webView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(17)
            make.left.equalToSuperview().offset(17)
            make.height.equalToSuperview().multipliedBy(0.45)
        }
        
        titleLabel.text = "Solving..."
        titleLabel.textAlignment = .center
        titleLabel.font = Font.custom(size: 28, fontWeight: .Bold)
        self.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(7)
            make.left.right.equalToSuperview()
        }
            
        plusImageView.image = UIImage(named: AppStrings.plusImage)
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
}
