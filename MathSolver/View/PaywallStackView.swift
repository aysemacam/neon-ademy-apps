import UIKit
import NeonSDK
import SnapKit

class PaywallStackView: UIView {
    
    let stackView: NeonVStack
    
    override init(frame: CGRect) {
        stackView = NeonVStack(width: 373) { vStack in
            
            let subview1 = UIView()
            subview1.backgroundColor = UIColor(named: AppStrings.paywallViewBackground)
            subview1.layer.cornerRadius = 25
            subview1.layer.masksToBounds = true
            vStack.addArrangedSubview(subview1)
            
            subview1.snp.makeConstraints { make in
                make.height.equalTo(82)
            }

            let label1 = UILabel()
            label1.font = Font.custom(size: 15, fontWeight: .Medium)
            let originalText1 = AppStrings.payment1
            var mutableString1 = NSMutableAttributedString()
            mutableString1 = NSMutableAttributedString(string: originalText1, attributes: [:])
            mutableString1.addAttribute(NSAttributedString.Key.font, value: Font.custom(size: 18, fontWeight: .SemiBold), range: NSRange(location: 9, length: 4))
            label1.attributedText = mutableString1
            subview1.addSubview(label1)
            
            label1.snp.makeConstraints { make in
                make.left.equalTo(subview1).offset(30)
                make.centerY.equalTo(subview1)
            }
            
            let button1 = UIButton()
            button1.setImage(UIImage(named: AppStrings.unselectedPay), for: .normal)
            subview1.addSubview(button1)
            button1.snp.makeConstraints { make in
                make.centerY.equalTo(subview1)
                make.right.equalTo(subview1.snp.right).offset(-5)
            }
       
            let clearView = UIView()
            clearView.backgroundColor = .clear
            vStack.addSubview(clearView)
            
            clearView.snp.makeConstraints { make in
                make.height.equalTo(23)
            }
            
            let subview2 = UIView()
            subview2.backgroundColor = UIColor(named: AppStrings.paywallViewBackground)
            subview2.layer.cornerRadius = 25
            subview2.layer.masksToBounds = true
            vStack.addArrangedSubview(subview2)
            
            subview2.snp.makeConstraints { make in
                make.height.equalTo(82)
            }

            let label2 = UILabel()
            label2.font = Font.custom(size: 15, fontWeight: .Medium)
            let originalText2 = AppStrings.payment2
            var mutableString2 = NSMutableAttributedString()
            mutableString2 = NSMutableAttributedString(string: originalText2, attributes: [:])
            mutableString2.addAttribute(NSAttributedString.Key.font, value: Font.custom(size: 18, fontWeight: .SemiBold), range: NSRange(location: 8, length: 4))
            label2.attributedText = mutableString2
            subview2.addSubview(label2)
            
            label2.snp.makeConstraints { make in
                make.left.equalTo(subview2).offset(30)
                make.centerY.equalTo(subview2)
            }
            
            let button2 = UIButton()
            button2.setImage(UIImage(named: AppStrings.unselectedPay), for: .normal)

            subview2.addSubview(button2)
            button2.snp.makeConstraints { make in
                make.centerY.equalTo(subview2)
                make.right.equalTo(subview2.snp.right).offset(-5)
            }
        }
        
        super.init(frame: frame)
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func button2Tapped() {
        
        }
    }
