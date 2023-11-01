import UIKit
import NeonSDK
import SnapKit

import UIKit

class SolutionBackgroundView: UIView {

    let imageView1 = UIImageView()
    let imageView2 = UIImageView()
    let imageView3 = UIImageView()
    let customView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {

        self.backgroundColor = .black.withAlphaComponent(0.5)
        
        imageView1.image = UIImage(named: AppStrings.solutionBackgroundImg1)
        self.addSubview(imageView1)
        
        imageView1.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview().offset(20)
            
        }
        
        imageView2.image = UIImage(named: AppStrings.solutionBackgroundImg1)
        self.addSubview(imageView2)
        
        imageView2.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        customView.backgroundColor = .black.withAlphaComponent(0.5)
        self.addSubview(customView)
        
        customView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            
        }
    
        imageView3.image = UIImage(named: AppStrings.solutionBackgroundImg2)
        imageView3.contentMode = .scaleAspectFit
        customView.addSubview(imageView3)
        
        imageView3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
}

