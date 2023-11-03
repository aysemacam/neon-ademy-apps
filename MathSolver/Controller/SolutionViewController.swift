//
//  SolutionViewController.swift
//  MathSolver


import UIKit
import SnapKit
import NeonSDK
import WebKit
import OpenAI

class SolutionViewController: UIViewController {
    
    let backgroundView = SolutionBackgroundView()
    let contentView = SolutionContentView()
    var latexResult: String?
    let backgroundImage = UIImageView()
    let openAI = OpenAIApiService()
    var contentViewHeightConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let latexResult = latexResult {
            displayLatexInWebView(latexResult)
            openAI.askQuestion(latexResult) { (answer) in
                print("Answer: \(answer)")
                DispatchQueue.main.async {
                    self.contentViewHeightConstraint?.deactivate()
                    self.contentView.snp.makeConstraints { make in
                        self.contentViewHeightConstraint = make.height.equalToSuperview().multipliedBy(0.38).constraint
                    }
                    self.view.layoutIfNeeded()
                    self.contentView.updateUI()
                    if let solutionRange = answer.range(of: "Solution: ") {
                        let solutionPart = String(answer[solutionRange.upperBound...])
                        self.contentView.textLabel.text = solutionPart.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                    
                }
            }
        }
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
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().inset(26)
            contentViewHeightConstraint = make.height.equalToSuperview().multipliedBy(0.21).constraint
        }
    }
    
    func displayLatexInWebView(_ latex: String) {
        let htmlString = """
            <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <script type="text/javascript" async
                    src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
                </script>
                <style>
                    p {
                        font-family: Arial, sans-serif;
                        font-size: 20px;
                        text-align: center;
                    }
                </style>
            </head>
            <body>
                <p>\\[
                    \(latex)
                \\]</p>
            </body>
            </html>
        """
        contentView.webView.loadHTMLString(htmlString, baseURL: nil)
       
    }
    
}
