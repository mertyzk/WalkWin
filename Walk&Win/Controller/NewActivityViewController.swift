//
//  NewActivityViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 18.08.2022.
//

import UIKit

class NewActivityViewController: UIViewController {
    
    lazy var goBackHome: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gohome")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "New Activity"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .light)
        return label
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "helpimage")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        GradientManagement.shared.setGradient(incomingView: view)
        addTargetForNewActivity()
        setToNewActivityVCLayout()
    }
    
    fileprivate func setToNewActivityVCLayout(){
        view.addSubview(goBackHome)
        view.addSubview(topLabel)
        view.addSubview(infoButton)
        goBackHome.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 15, bottom: 0, right: 0))
        topLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
        infoButton.anchor(top: nil, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        infoButton.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
    }
    
    fileprivate func addTargetForNewActivity(){
        goBackHome.addTarget(self, action: #selector(goBackHomeClicked), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(infoButtonClicked), for: .touchUpInside)
    }
    
    @objc fileprivate func goBackHomeClicked(){
        goToHomepage()
    }
    
    @objc fileprivate func infoButtonClicked(){
        let alert = UIAlertController(title: "Information", message: "To start a new activity, you must press the start button. When you complete your activity, you can save it by pressing the finish button.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    fileprivate func goToHomepage(){
        let goToHomepage: DashboardViewController = DashboardViewController()
        goToHomepage.modalPresentationStyle = .fullScreen
        goToHomepage.modalTransitionStyle = .crossDissolve
        self.present(goToHomepage, animated: true)
    }
    



}
