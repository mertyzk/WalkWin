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
    
    var locationManager: CLLocationManager?
    let newActivityUI = NewActivityView()
    
    var activityDistance: Double = 0.0
    var firstPosition: CLLocation!
    var lastPosition: CLLocation!
    var activityStatus: Bool = false
    
    var timeCounter: Int = 0
    var timer = Timer()
    var resetStatus: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        checkPermission()
        addTargetForNewActivity()
        GradientManagement.shared.setGradient(incomingView: view)
        showLayout()
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        setLocationSettings()
    }

    fileprivate func addTargetForNewActivity(){
        newActivityUI.goBackHome.addTarget(self, action: #selector(goBackHomeClicked), for: .touchUpInside)
        newActivityUI.infoButton.addTarget(self, action: #selector(infoButtonClicked), for: .touchUpInside)
        newActivityUI.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        newActivityUI.stopButton.addTarget(self, action: #selector(stopButtonClicked), for: .touchUpInside)
        let notificationCenter: NotificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(dinliyorum), name: NSNotification.Name("dinleyen"), object: nil)

    }
    
    @objc func dinliyorum(){
        locationManager?.startUpdatingLocation()
    }
    
    fileprivate func setLocationSettings(){
        locationManager?.delegate = self
        newActivityUI.mapView.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        newActivityUI.mapView.showsUserLocation = true
        locationManager?.activityType = .fitness
        locationManager?.distanceFilter = 5
    }
    
    fileprivate func checkPermission(){
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    func showLayout(){
        view.addSubview(newActivityUI)
        newActivityUI.frame = view.bounds
        newActivityUI.setToNewActivityVCLayout()
    }
    
    func startTimer(){
        newActivityUI.timeLabel.text = "\(timeCounter) sec"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateForCounter), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        timer.invalidate()
    }
    

    //-MARK: @OBJC Selector Functions
    @objc fileprivate func goBackHomeClicked(){
        goToHomepage()
    }
    
    @objc func startButtonClicked(){
        
        let goToPopup: PopUpWindow = PopUpWindow()
        goToPopup.popUpWindowView.newActivityNameLayout()
        self.present(goToPopup, animated: true, completion: nil)
        
        /*if (newActivityUI.activityNameTextField.text == ""){
            let alert = UIAlertController(title: "Warning!", message: "Enter an activity name to start a new activity.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true)
        } else {
            locationManager?.startUpdatingLocation()
            activityStatus = true
            newActivityUI.stopButton.isEnabled = true
            startTimer()
            newActivityUI.startButton.isEnabled = false
        }*/
    }
    
    @objc func stopButtonClicked(){
        newActivityUI.stopButton.isEnabled = false
        locationManager?.stopUpdatingLocation()
        stopTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
            self.goToHistory()
        }
    }
    
    
    @objc func updateForCounter(){
        timeCounter = timeCounter + 1
        newActivityUI.timeLabel.text = "\(timeCounter) sec"
    }
    
    @objc fileprivate func infoButtonClicked(){
        let alert = UIAlertController(title: "Information", message: "To start a new activity, you must press the start button. When you complete your activity, you can save it by pressing the finish button.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
    

    
    //-MARK: Navigation Helper Functions
    fileprivate func goToHomepage(){
        let goToHomepage: DashboardViewController = DashboardViewController()
        goToHomepage.modalPresentationStyle = .fullScreen
        goToHomepage.modalTransitionStyle = .crossDissolve
        self.present(goToHomepage, animated: true)
    }
    
    fileprivate func goToHistory(){
        let goToHistoryVC: HistoryViewController = HistoryViewController()
        goToHistoryVC.modalPresentationStyle = .fullScreen
        goToHistoryVC.modalTransitionStyle = .crossDissolve
        self.present(goToHistoryVC, animated: true)
    }


}

extension NewActivityViewController: CLLocationManagerDelegate, MKMapViewDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if firstPosition == nil {
            firstPosition = locations.first
        } else if let myLoc = locations.last {
            activityDistance += lastPosition.distance(from: myLoc)
            let stringDistance = String(format: "%.1f", activityDistance) // meter and only x.0
            if(activityStatus == true) {
                if (resetStatus == false){
                    activityDistance = 0
                    resetStatus = true
                }
                newActivityUI.distanceLabel.text = "\(stringDistance) m"
                newActivityUI.velocityLabel.text = "\(lastPosition.speed)"
                if (timeCounter > 0){
                    print(activityDistance / Double(timeCounter))
                }
            }

        }
        
        lastPosition = locations.last
        
        let location = CLLocationCoordinate2D(latitude: lastPosition.coordinate.latitude, longitude: lastPosition.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.0033, longitudeDelta: 0.0033)
        let zone = MKCoordinateRegion(center: location, span: span)
        newActivityUI.mapView.setRegion(zone, animated: true)

    }
    
}
