//
//  SolvingStepsVC.swift
//  MathSolver

import NeonSDK
import UIKit

class SolvingStepsVC: NeonViewController {
    let solvingStepView = SolvingStepView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        

    }
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(solvingStepView)
        solvingStepView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(24)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.right.equalToSuperview().inset(24)
        }
    }


}
