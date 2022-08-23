//
//  NewActivityViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 18.08.2022.
//

import UIKit
import MapKit
import CoreLocation

class NewActivityViewController: UIViewController {
    
    var locationManager: CLLocationManager = CLLocationManager()
    
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
    
    lazy var mapView : MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        return map
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Activity", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop Activity", for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        button.backgroundColor = .systemPink
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.isEnabled = false
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startButton, stopButton])
        stackView.axis = .horizontal
        stackView.spacing = 25
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return stackView
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
        addTargetForNewActivity()
        setToNewActivityVCLayout()
        setLocationSettings()
        locationManager.requestWhenInUseAuthorization()
    }
    
    fileprivate func setLocationSettings(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    setLocationSettings()
                }
            }
        }
    }
    
    lazy var screenHeight = view.frame.size.height
    lazy var screenWidth = view.frame.size.width
    fileprivate func setToNewActivityVCLayout(){
        view.addSubview(goBackHome)
        view.addSubview(topLabel)
        view.addSubview(infoButton)
        view.addSubview(mapView)
        view.addSubview(buttonStackView)
        view.addSubview(titleStackView)
        view.addSubview(labelStackView)
        mapView.addSubview(weatherLabel)
        
        goBackHome.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 5, left: 15, bottom: 0, right: 0))
        topLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
        infoButton.anchor(top: nil, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        infoButton.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
        
        if (screenHeight < 668){
            mapView.anchor(top: infoButton.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 0, bottom: (275 * screenHeight) / 926, right: 0))
        } else {
            
            mapView.anchor(top: infoButton.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 0, bottom: (220 * screenHeight) / 926, right: 0))
        }
        
        buttonStackView.anchor(top: mapView.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        titleStackView.anchor(top: buttonStackView.bottomAnchor, bottom: nil, leading: buttonStackView.leadingAnchor, trailing: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        
        labelStackView.anchor(top: buttonStackView.bottomAnchor, bottom: nil, leading: nil, trailing: buttonStackView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        
        weatherLabel.anchor(top: mapView.topAnchor, bottom: nil, leading: nil, trailing: mapView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 10), size: .init(width: 75, height: 50))

    }
    
    fileprivate func addTargetForNewActivity(){
        goBackHome.addTarget(self, action: #selector(goBackHomeClicked), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(infoButtonClicked), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc fileprivate func goBackHomeClicked(){
        goToHomepage()
    }
    
    @objc func startButtonClicked(){
        let goToPopup: PopUpWindow = PopUpWindow()
        goToPopup.popUpWindowView.newActivityNameLayout()
        self.present(goToPopup, animated: true, completion: nil)
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

extension NewActivityViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastPosition: CLLocation = locations[locations.count - 1]
        let location = CLLocationCoordinate2D(latitude: lastPosition.coordinate.latitude, longitude: lastPosition.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let zone = MKCoordinateRegion(center: location, span: span)
        print("################## \(lastPosition.coordinate.latitude) \(lastPosition.coordinate.longitude)")
        mapView.setRegion(zone, animated: true)
    }
    
}
