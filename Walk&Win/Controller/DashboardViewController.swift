//
//  DashboardViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 18.08.2022.
//

import UIKit

class DashboardViewController: UIViewController {
    
    lazy var listButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "listmenu")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome User"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .light)
        return label
    }()
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "accountcircle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [listButton, welcomeLabel, settingsButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "leftarea")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightArea")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var leftImageLabel: UILabel = {
        let label = UILabel()
        label.text = "Activities"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    lazy var rightImageLabel: UILabel = {
        let label = UILabel()
        label.text = "Timeline"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftImageView, leftImageLabel])
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var leftUIView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rightImageView, rightImageLabel])
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    
    lazy var rightUIView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var activityNumber: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        return label
    }()
    
    lazy var timeNumber: UILabel = {
        let label = UILabel()
        label.text = "48h"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        return label
    }()
    
    lazy var newActivity: UIButton = {
        let button = UIButton()
        button.setTitle("NEW ACTIVITY", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        button.backgroundColor = .systemPink
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        GradientManagement.shared.setGradient(incomingView: view)
        addTargetForDashboard()
        setDashboardLayout()
    }


    
    lazy var screenHeight = view.frame.size.height
    lazy var screenWidth = view.frame.size.width
    func setDashboardLayout(){
        view.addSubview(topStackView)
        view.addSubview(leftUIView)
        leftUIView.addSubview(leftStackView)
        view.addSubview(rightUIView)
        rightUIView.addSubview(rightStackView)
        leftUIView.addSubview(activityNumber)
        rightUIView.addSubview(timeNumber)
        view.addSubview(newActivity)
        
        topStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 15, bottom: 0, right: 15))
        
        leftUIView.anchor(top: topStackView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 30, left: 15, bottom: 0, right: 0), size: .init(width: (185 * screenWidth) / 428 , height: 140))
        
        leftStackView.anchor(top: leftUIView.topAnchor, bottom: nil, leading: leftUIView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        
        rightUIView.anchor(top: topStackView.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 15), size: .init(width: (185 * screenWidth) / 428, height: 140))
        
        rightStackView.anchor(top: rightUIView.topAnchor, bottom: nil, leading: rightUIView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        
        activityNumber.anchor(top: leftStackView.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        activityNumber.centerXAnchor.constraint(equalTo: leftUIView.centerXAnchor).isActive = true
        
        timeNumber.anchor(top: rightStackView.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        timeNumber.centerXAnchor.constraint(equalTo: rightUIView.centerXAnchor).isActive = true
        
        newActivity.anchor(top: nil, bottom: nil, leading: nil, trailing: nil)
        newActivity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newActivity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func addTargetForDashboard(){
        listButton.addTarget(self, action: #selector(listButtonClicked), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonClicked), for: .touchUpInside)
        newActivity.addTarget(self, action: #selector(newActivityButtonClicked), for: .touchUpInside)
    }
    
    @objc fileprivate func listButtonClicked(){
        goToHistoryVC()
    }
    
    @objc fileprivate func settingsButtonClicked(){
        goToSettingsVC()
    }
    
    @objc fileprivate func newActivityButtonClicked(){
        goToNewActivityVC()
    }
    
    fileprivate func goToSettingsVC(){
        let goToSettings: SettingsViewController = SettingsViewController()
        goToSettings.modalPresentationStyle = .fullScreen
        goToSettings.modalTransitionStyle = .crossDissolve
        self.present(goToSettings, animated: true)
    }
    
    fileprivate func goToHistoryVC(){
        let goToHistory: HistoryViewController = HistoryViewController()
        goToHistory.modalPresentationStyle = .fullScreen
        goToHistory.modalTransitionStyle = .crossDissolve
        self.present(goToHistory, animated: true)
    }
    
    fileprivate func goToNewActivityVC(){
        let goToNewActivity: NewActivityViewController = NewActivityViewController()
        goToNewActivity.modalPresentationStyle = .fullScreen
        goToNewActivity.modalTransitionStyle = .crossDissolve
        self.present(goToNewActivity, animated: true)
    }
    
}
