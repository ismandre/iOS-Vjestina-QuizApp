//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Andrea Stanic on 14.04.2021..
//

import UIKit

class QuizzesViewController: UIViewController {
    
    let cellIdentifier = "cellId"

    private var appNameLabel: UILabel!
    private var getQuizButton: UIButton!
    private var funFactLabel: UILabel!
    private var infoLabel: UILabel!
    
    private var tableView: UITableView!
    
    private var ds = DataService()
    
    let relativeFontConstant:CGFloat = 0.05
    let relativeFontFunFactConstant:CGFloat = 0.025
    let relativeInfoConstant:CGFloat = 0.015

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

        appNameLabel = UILabel()
        appNameLabel.backgroundColor = UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 0)
        appNameLabel.text = "PopQuiz"
        appNameLabel.textAlignment = .center
        appNameLabel.font = UIFont(name: "Superclarendon-Black", size: UIScreen.main.bounds.height * relativeFontConstant)
        appNameLabel.textColor = .white

        getQuizButton = UIButton()
        getQuizButton.backgroundColor = .white
        getQuizButton.setTitle("Get Quiz", for: .normal)
        getQuizButton.setTitleColor(UIColor(red: 0.455, green: 0.310, blue: 0.639, alpha: 1), for: .normal)
        getQuizButton.titleLabel?.font = UIFont(name: "Superclarendon-Black", size: 15)
        getQuizButton.layer.cornerRadius = 22.0
        
        getQuizButton.addTarget(self, action: #selector(getQuizAction), for: .touchUpInside)
        
        
        funFactLabel = UILabel()
        funFactLabel.text = "Fun Fact"
        funFactLabel.textColor = .white
        funFactLabel.font = UIFont(name: "Superclarendon-Black", size: UIScreen.main.bounds.height * relativeFontFunFactConstant)
        funFactLabel.isHidden = true
        
        infoLabel = UILabel()
        infoLabel.textColor = .white
        infoLabel.font = UIFont(name: "Superclarendon-Regular", size: UIScreen.main.bounds.height * relativeInfoConstant)
        infoLabel.isHidden = true
        
        
        tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.dataSource = self
        tableView.backgroundColor = nil
        tableView.isHidden = true
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        // tableView.
        
        
        view.addSubview(tableView)
        view.addSubview(infoLabel)
        view.addSubview(funFactLabel)
        view.addSubview(appNameLabel)
        view.addSubview(getQuizButton)
    }

    private func addConstraints() {
        
        appNameLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        appNameLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 50)
        //appNameLabel.autoSetDimensions(to: CGSize(width: 140, height: 30))
        
        getQuizButton.autoAlignAxis(.vertical, toSameAxisOf: appNameLabel)
        getQuizButton.autoPinEdge(.top, to: .bottom, of: appNameLabel, withOffset: 30)
        getQuizButton.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 50))
        
        funFactLabel.autoPinEdge(.leading, to: .leading, of: getQuizButton)
        funFactLabel.autoPinEdge(.top, to: .bottom, of: getQuizButton, withOffset: 25)
        // funFactLabel.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 15))
        
        infoLabel.autoPinEdge(.leading, to: .leading, of: getQuizButton)
        infoLabel.autoPinEdge(.top, to: .bottom, of: funFactLabel, withOffset: 5)
        // infoLabel.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: 15))
        
        tableView.autoPinEdge(.top, to: .bottom, of: infoLabel, withOffset: 20)
        // pinaj leading, trailing, bottom
        tableView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.size.width * 0.9, height: CGFloat(ds.fetchQuizes().capacity) * UIScreen.main.bounds.size.height * 0.25))
        tableView.autoAlignAxis(.vertical, toSameAxisOf: appNameLabel)

    }
    
    @objc
    private func getQuizAction() {
        let quizzes = ds.fetchQuizes()
        let totalNBA = quizzes.map{ $0.questions }.flatMap{ $0 }.map{ $0.question }.filter{ $0.contains("NBA")}.reduce(0, {x, y in x + 1})
        
        infoLabel.text = "There are " + String(totalNBA) + " questions that contain the word \"NBA\""
        funFactLabel.isHidden = false
        infoLabel.isHidden = false
        tableView.isHidden = false
        
    }
}


extension QuizzesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(section)
        if (section == 0) {
            return ds.fetchQuizes().filter { $0.category == .sport }.capacity
        } else {
            return ds.fetchQuizes().filter { $0.category == .science }.capacity
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                 for: indexPath) as? CustomTableViewCell else {
                                                    return UITableViewCell()
                                                 }
        print()
        
        cell.configure(name: "Quiz Name", desc: "This is default description of quiz that is being displayed. This is some more text.", imageName: "sport.jpeg")
        cell.backgroundColor = UIColor(red: 0, green: 0.39, blue: 0.106, alpha: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height * 0.25
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let sectionName: String
        switch section {
            case 0:
                sectionName = NSLocalizedString("Sport", comment: "Sport")
            case 1:
                sectionName = NSLocalizedString("Science", comment: "Science")
            // ...
            default:
                sectionName = ""
        }
        return sectionName
    }
    
    
}


