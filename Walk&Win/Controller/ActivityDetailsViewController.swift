//
//  ActivityDetailsViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 18.08.2022.
//

import UIKit
import MapKit
import CoreLocation

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
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "accountcircle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var mapView : MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        return map
    }()
    
    lazy var activityNameLabel: UILabel = {
        let label = PaddingLabel()
        label.text = "Kurtuluş Parkı Koşu"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.clipsToBounds = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.edgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return label
    }()
    
    lazy var distanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Distance"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.backgroundColor = #colorLiteral(red: 0.3865185976, green: 0.4198502302, blue: 0.4646711349, alpha: 1)
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 145).isActive = true
        label.clipsToBounds = true
        return label
    }()
    
    lazy var velocityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Velocity"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.backgroundColor = #colorLiteral(red: 0.3865185976, green: 0.4198502302, blue: 0.4646711349, alpha: 1)
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 145).isActive = true
        label.clipsToBounds = true
        return label
    }()
    
    lazy var timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Time"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.backgroundColor = #colorLiteral(red: 0.3865185976, green: 0.4198502302, blue: 0.4646711349, alpha: 1)
        label.widthAnchor.constraint(equalToConstant: 145).isActive = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [distanceTitleLabel, velocityTitleLabel, timeTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "1574 m"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        label.widthAnchor.constraint(equalToConstant: 145).isActive = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    lazy var velocityLabel: UILabel = {
        let label = UILabel()
        label.text = "16 km/h"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        label.widthAnchor.constraint(equalToConstant: 145).isActive = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "19 dk"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        label.widthAnchor.constraint(equalToConstant: 145).isActive = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [distanceLabel, velocityLabel, timeLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "22 °C"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        label.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.layer.cornerRadius = 5
        label.textAlignment = .center
        label.clipsToBounds = true
        label.isUserInteractionEnabled = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        GradientManagement.shared.setGradient(incomingView: view)
        addTargetForActivityDetail()
        setToActivityVCLayout()
    }
    
    lazy var screenHeight = view.frame.size.height
    lazy var screenWidth = view.frame.size.width
    fileprivate func setToActivityVCLayout(){
        view.addSubview(goBackHome)
        view.addSubview(topLabel)
        view.addSubview(settingsButton)
        view.addSubview(mapView)
        view.addSubview(activityNameLabel)
        view.addSubview(titleStackView)
        view.addSubview(labelStackView)
        mapView.addSubview(weatherLabel)
        
        
        goBackHome.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 5, left: 15, bottom: 0, right: 0))
        topLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        settingsButton.anchor(top: nil, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        settingsButton.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
        
        if (screenHeight < 668){
            mapView.anchor(top: topLabel.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 0, bottom: (275 * screenHeight) / 926, right: 0))
        } else {
            mapView.anchor(top: topLabel.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 0, bottom: (220 * screenHeight) / 926, right: 0))
        }
        
        weatherLabel.anchor(top: mapView.topAnchor, bottom: nil, leading: nil, trailing: mapView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 10), size: .init(width: 75, height: 50))
        
        activityNameLabel.anchor(top: mapView.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        activityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        titleStackView.anchor(top: activityNameLabel.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        
        labelStackView.anchor(top: activityNameLabel.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        
        titleStackView.centerXAnchor.constraint(equalTo: activityNameLabel.leadingAnchor, constant: 20).isActive = true
        labelStackView.centerXAnchor.constraint(equalTo: activityNameLabel.trailingAnchor, constant: -20).isActive = true
        
        
    }
    
    fileprivate func addTargetForActivityDetail(){
        goBackHome.addTarget(self, action: #selector(goBackHomeClicked), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonClicked), for: .touchUpInside)
    }
    
    @objc fileprivate func goBackHomeClicked(){
        goToHomepage()
    }
    
    @objc func settingsButtonClicked(){
        let goToSettings: SettingsViewController = SettingsViewController()
        goToSettings.modalPresentationStyle = .fullScreen
        goToSettings.modalTransitionStyle = .crossDissolve
        self.present(goToSettings, animated: true)
    }
    
    fileprivate func goToHomepage(){
        let goToHomepage: DashboardViewController = DashboardViewController()
        goToHomepage.modalPresentationStyle = .fullScreen
        goToHomepage.modalTransitionStyle = .crossDissolve
        self.present(goToHomepage, animated: true)
    }

}
