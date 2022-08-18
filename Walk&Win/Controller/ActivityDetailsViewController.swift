//
//  ActivityDetailsViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 18.08.2022.
//

import UIKit

class ActivityDetailsViewController: UIViewController {
    
    lazy var goBackHome: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gohome")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Details of Activity"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .light)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        GradientManagement.shared.setGradient(incomingView: view)
        addTargetForActivityDetail()
        setToActivityVCLayout()
    }
    
    fileprivate func setToActivityVCLayout(){
        view.addSubview(goBackHome)
        view.addSubview(topLabel)
        goBackHome.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 5, left: 15, bottom: 0, right: 0))
        topLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
    }
    
    fileprivate func addTargetForActivityDetail(){
        goBackHome.addTarget(self, action: #selector(goBackHomeClicked), for: .touchUpInside)
    }
    
    @objc fileprivate func goBackHomeClicked(){
        goToHomepage()
    }
    
    fileprivate func goToHomepage(){
        let goToHomepage: DashboardViewController = DashboardViewController()
        goToHomepage.modalPresentationStyle = .fullScreen
        goToHomepage.modalTransitionStyle = .crossDissolve
        self.present(goToHomepage, animated: true)
    }

}
