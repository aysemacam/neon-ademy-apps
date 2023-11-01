//
//  SolutionView.swift
//  MathSolver


import Foundation
import UIKit
import SnapKit

class SolutionContentView: UIView {
    
    let titleLabel = UILabel()
    let resultLabel = UILabel()

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
        
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        self.addSubview(resultLabel)
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        titleLabel.text = "Solving..."
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        self.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(7)
            make.left.right.equalToSuperview()
        }
    }
}
