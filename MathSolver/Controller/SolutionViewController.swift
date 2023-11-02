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
    var latexResult: String?
    let backgroundImage = UIImageView()
    let openAIManager = OpenAIManager()
 

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let latexResult = latexResult {
             displayLatexInWebView(latexResult)
            openAIManager.askSolutionForMathProblem(latexResult) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let answer):
                        print("Sonuç:", answer)
                        // self?.resultLabel.text = answer
                    case .failure(let error):
                        print("Hata:", error.localizedDescription)
                        // Maybe display an error message to the user.
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(248)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().inset(26)
            make.height.equalToSuperview().multipliedBy(0.21)
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
               </head>
               <body>
                   <p>\\[
                       \(latex)
                   \\]</p>
               </body>
               </html>
           """
        contentView.webView.loadHTMLString(htmlString, baseURL: nil)
        print(htmlString, "html string")
        print(contentView.webView.url!, "url")
    }
}
