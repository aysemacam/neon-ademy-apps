//
//  SolutionViewController.swift
//  MathSolver


import UIKit
import SnapKit
import NeonSDK
import WebKit

class SolutionViewController: UIViewController {
    
    let backgroundView = SolutionBackgroundView()
    let contentView = SolutionContentView()
    let plusImageView = UIImageView()
    var latexResult: String?
    let backgroundImage = UIImageView()
    var webView: WKWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        view.backgroundColor = .white
        
        backgroundImage.image = UIImage(named: AppStrings.imgBackground)
        view.addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        view.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.resultLabel.text = latexResult ?? "No solution available"
        view.addSubview(contentView)

        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(248)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().inset(26)
            make.height.equalToSuperview().multipliedBy(0.21)
        }
        
        plusImageView.image = UIImage(named: AppStrings.plusImage)
        plusImageView.layer.shadowColor = UIColor.black.cgColor
        plusImageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        plusImageView.layer.shadowRadius = 5
        plusImageView.layer.shadowOpacity = 0.4
        view.addSubview(plusImageView)
        
        plusImageView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.top).offset(50)
            make.centerX.equalTo(contentView)
        }
    }
}

//func setupUI() {
//       view.backgroundColor = .white
//       
//       backgroundImage.image = UIImage(named: AppStrings.imgBackground)
//       view.addSubview(backgroundImage)
//       
//       backgroundImage.snp.makeConstraints { make in
//           make.top.equalTo(view.safeAreaLayoutGuide)
//           make.left.right.bottom.equalToSuperview()
//       }
//       
//       view.addSubview(backgroundView)
//       backgroundView.snp.makeConstraints { make in
//           make.edges.equalToSuperview()
//       }
//       
//       webView = WKWebView()
//       contentView.addSubview(webView)
//
//       webView.snp.makeConstraints { make in
//           make.edges.equalToSuperview()
//       }
//
//       let mathJaxUrl = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/3.2.0/es5/tex-mml-chtml.js"
//       let latexExpression = latexResult ?? "No solution available"
//       let htmlContent = """
//       <html>
//       <head>
//           <script type="text/javascript" async src="\(mathJaxUrl)"></script>
//       </head>
//       <body>
//           <script type="text/javascript">
//               MathJax = {
//                   tex: {
//                       inlineMath: [['$', '$'], ['\\(', '\\)']]
//                   },
//                   svg: {
//                       fontCache: 'global'
//                   }
//               };
//           </script>
//           <p>
//               \\(\(latexExpression)\\)
//           </p>
//       </body>
//       </html>
//       """
//       
//       webView.loadHTMLString(htmlContent, baseURL: nil)
//
//       contentView.resultLabel.text = latexResult ?? "No solution available"
//       view.addSubview(contentView)
//
//       contentView.snp.makeConstraints { make in
//           make.top.equalTo(view.safeAreaLayoutGuide).offset(248)
//           make.left.equalToSuperview().offset(26)
//           make.right.equalToSuperview().inset(26)
//           make.height.equalToSuperview().multipliedBy(0.21)
//       }
//       
//       plusImageView.image = UIImage(named: AppStrings.plusImage)
//       plusImageView.layer.shadowColor = UIColor.black.cgColor
//       plusImageView.layer.shadowOffset = CGSize(width: 0, height: 5)
//       plusImageView.layer.shadowRadius = 5
//       plusImageView.layer.shadowOpacity = 0.4
//       view.addSubview(plusImageView)
//       
//       plusImageView.snp.makeConstraints { make in
//           make.bottom.equalTo(contentView.snp.top).offset(50)
//           make.centerX.equalTo(contentView)
//       }
//   }
