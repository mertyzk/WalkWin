//
//  SettingsViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 18.08.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    lazy var goBackHome: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gohome")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Settings"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .light)
        return label
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "exitapp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GradientManagement.shared.setGradient(incomingView: view)
        addTargetForSettings()
        setToSettingsVCLayout()
    }
    
    fileprivate func setToSettingsVCLayout(){
        view.addSubview(goBackHome)
        view.addSubview(topLabel)
        view.addSubview(exitButton)
        goBackHome.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 15, bottom: 0, right: 0))
        topLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
        exitButton.anchor(top: nil, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        exitButton.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
    }
    
    fileprivate func addTargetForSettings(){
        goBackHome.addTarget(self, action: #selector(goBackHomeClicked), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonClicked), for: .touchUpInside)
    }
    
    @objc fileprivate func goBackHomeClicked(){
        goToHomepage()
    }
    
    @objc fileprivate func exitButtonClicked(){
        print("#################### U Y G U L A M A D A N    Ç I K I Ş    Y A P ####################")
    }
    
    fileprivate func goToHomepage(){
        let goToHomepage: DashboardViewController = DashboardViewController()
        goToHomepage.modalPresentationStyle = .fullScreen
        goToHomepage.modalTransitionStyle = .crossDissolve
        self.present(goToHomepage, animated: true)
    }

}
