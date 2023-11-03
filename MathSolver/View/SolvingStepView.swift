import UIKit
import NeonSDK
import SnapKit

import UIKit

class SolvingStepView: UIView {

    let titleLabel = UILabel()
    let contentText = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        
        titleLabel.text = "Question"
        titleLabel.textAlignment = .left
        titleLabel.font = Font.custom(size: 22, fontWeight: .Bold)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(18)
        }
        contentText.text = "content"
        contentText.font = Font.custom(size: 15, fontWeight: .Medium)
        self.addSubview(contentText)
        
        contentText.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(9)
            make.left.equalToSuperview().offset(18)
        }
    }
}

