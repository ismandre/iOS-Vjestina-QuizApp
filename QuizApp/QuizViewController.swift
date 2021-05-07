//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Andrea Stanic on 05.05.2021..
//

import SwiftUI
import PureLayout
import SGSegmentedProgressBarLibrary

class QuizViewController: UIViewController {
    
    private var segmentBar: SGSegmentedProgressBar!
    
    private var currentQuestionLabel: UILabel!
    private var questionLabel: UILabel!
    private var answer1Button: UIButton!
    private var answer2Button: UIButton!
    private var answer3Button: UIButton!
    private var answer4Button: UIButton!
    
    let relativeFontConstant:CGFloat = 0.05

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        addConstraints()
    }

    private func buildViews() {
    
        view.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 1)
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
          UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -1.95, b: 1.41, c: -1.41, d: -0.41, tx: 2.02, ty: -0.01))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        
        currentQuestionLabel = UILabel()
        currentQuestionLabel.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 0)
        currentQuestionLabel.text = "1/8"
        currentQuestionLabel.font = UIFont(name: "SourceSansPro-Black", size: 18)
        currentQuestionLabel.textColor = .white
        
        
        let rect = CGRect(x: 20, y: 100, width: self.view.frame.size.width-40, height: 5)
        segmentBar = SGSegmentedProgressBar(frame: rect, delegate: self, dataSource: self)
        
        

        questionLabel = UILabel()
        questionLabel.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 0)
        questionLabel.text = "Who was the most famous Croatian basketball player in the NBA?"
        questionLabel.textAlignment = .left
        questionLabel.font = UIFont(name: "SourceSansPro-Black", size:24)
        questionLabel.textColor = .white
        
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 0

    
        answer1Button = UIButton()
        answer1Button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        answer1Button.setTitle("Dario Šarić", for: .normal)
        answer1Button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        answer1Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        answer1Button.layer.cornerRadius = 22.0
        answer1Button.contentHorizontalAlignment = .left
        answer1Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0);
        
        answer1Button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        
        answer2Button = UIButton()
        answer2Button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        answer2Button.setTitle("Dražen Petrović", for: .normal)
        answer2Button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        answer2Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        answer2Button.layer.cornerRadius = 22.0
        answer2Button.contentHorizontalAlignment = .left
        answer2Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0);
        
        answer2Button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        
        answer3Button = UIButton()
        answer3Button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        answer3Button.setTitle("Bojan Bogdanović", for: .normal)
        answer3Button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        answer3Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        answer3Button.layer.cornerRadius = 22.0
        answer3Button.contentHorizontalAlignment = .left
        answer3Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0);
        
        answer3Button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        
        answer4Button = UIButton()
        answer4Button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        answer4Button.setTitle("Dino Radja", for: .normal)
        answer4Button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        answer4Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 18)
        answer4Button.layer.cornerRadius = 22.0
        answer4Button.contentHorizontalAlignment = .left
        answer4Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0);
        
        answer4Button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        view.addSubview(currentQuestionLabel)
        view.addSubview(segmentBar)
        view.addSubview(questionLabel)
        view.addSubview(answer1Button)
        view.addSubview(answer2Button)
        view.addSubview(answer3Button)
        view.addSubview(answer4Button)
    }

    private func addConstraints() {
        
        currentQuestionLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        currentQuestionLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        
        segmentBar.autoPinEdge(.top, to: .bottom, of: currentQuestionLabel, withOffset: 20)
        segmentBar.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        segmentBar.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        
        questionLabel.autoPinEdge(.top, to: .bottom, of: segmentBar, withOffset: 30)
        questionLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        questionLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        questionLabel.sizeToFit()
        
        answer1Button.autoAlignAxis(toSuperviewAxis: .vertical)
        answer1Button.autoPinEdge(.top, to: .bottom, of: questionLabel, withOffset: 40)
        answer1Button.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer1Button.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer1Button.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
        
        answer2Button.autoAlignAxis(toSuperviewAxis: .vertical)
        answer2Button.autoPinEdge(.top, to: .bottom, of: answer1Button, withOffset: 15)
        answer2Button.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer2Button.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer2Button.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
        
        answer3Button.autoAlignAxis(toSuperviewAxis: .vertical)
        answer3Button.autoPinEdge(.top, to: .bottom, of: answer2Button, withOffset: 15)
        answer3Button.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer3Button.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer3Button.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
        
        answer4Button.autoAlignAxis(toSuperviewAxis: .vertical)
        answer4Button.autoPinEdge(.top, to: .bottom, of: answer3Button, withOffset: 15)
        answer4Button.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer4Button.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer4Button.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
    }
    
    @objc
    private func logoutAction() {
        print("button pressed")
    }
}


extension QuizViewController: SGSegmentedProgressBarDelegate, SGSegmentedProgressBarDataSource {
    
    func segmentedProgressBarFinished(finishedIndex: Int, isLastIndex: Bool) {
        print("progress bar")
    }
    
    var numberOfSegments: Int {
        return 8
    }
    
    var segmentDuration: TimeInterval {
        return 5
    }
    
    var paddingBetweenSegments: CGFloat {
        return 5
    }
    
    var trackColor: UIColor {
        return UIColor.white.withAlphaComponent(0.3)
    }
    
    var progressColor: UIColor {
        return UIColor.red
    }
    
    var roundCornerType: SGCornerType {
        return .roundCornerBar(cornerRadious: 5)
    }
}
