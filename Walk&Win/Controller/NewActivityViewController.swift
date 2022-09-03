//
//  NewActivityViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 18.08.2022.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

var activityName: String = ""

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
    var totalDistanceFromUser: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        checkPermission()
        addTargetForNewActivity()
        GradientManagement.shared.setGradient(incomingView: view)
        showLayout()
        getByTotalDistance()
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
        notificationCenter.addObserver(self, selector: #selector(locationUpdateFunction), name: NSNotification.Name("startUpdatingLocation"), object: nil)

    }
    
    @objc func locationUpdateFunction(){
        locationManager?.startUpdatingLocation()
        newActivityUI.startButton.isEnabled = false
        newActivityUI.stopButton.isEnabled = true
        activityStatus = true
        startTimer()
    }
    
    fileprivate func getByTotalDistance(){
        Firestore.firestore().collection("Users").document(currentUser!.userID ?? "000").getDocument { snapshot, error in
            if let error = error {
                print("Get data error: ", error)
                return
            }
            guard let userData = snapshot?.data() else { return }
            self.totalDistanceFromUser = userData["totalDistance"] as! Double
            
            
        }
    }
    
    fileprivate func setLocationSettings(){
        locationManager?.delegate = self
        newActivityUI.mapView.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        newActivityUI.mapView.showsUserLocation = true
        locationManager?.activityType = .fitness
        locationManager?.distanceFilter = 5
        locationManager?.startUpdatingLocation()
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
    }
    
    @objc func stopButtonClicked(){
        newActivityUI.stopButton.isEnabled = false
        locationManager?.stopUpdatingLocation()
        stopTimer()
        
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        let fireStore = Firestore.firestore()
        let convertDistance = String(format: "%.1f", activityDistance)
        activityDistance = Double(convertDistance)!
        totalDistanceFromUser += activityDistance
        let setData : [String : Any] = ["ActivityId" : UUID().uuidString, "ActivityDistance" : activityDistance, "ActivityName" : activityName, "UserId" : currentUser!.userID, "ActivityDate" : time]
        fireStore.collection("Activities").document().setData(setData, merge: true) { (error) in
            if error == nil {
                return
            }
            print("Save data success")
        }
        
        let userData : [String : Any] = ["totalDistance" : totalDistanceFromUser]
        fireStore.collection("Users").document(currentUser!.userID ?? "000").setData(userData, merge: true) { (error) in
            if error == nil {
                return
            }
            print("Save data success")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
            self.goToHistory()
        }
    }
    
    
    @objc func updateForCounter(){
        timeCounter = timeCounter + 1
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
                    //startTimer()
                    resetStatus = true
                }
                newActivityUI.distanceLabel.text = "\(stringDistance) m"
                newActivityUI.velocityLabel.text = "\(lastPosition.speed)"

                if (timeCounter > 0){
                    newActivityUI.timeLabel.text = "\(timeCounter) sec"
                }
            }

        }
        
        lastPosition = locations.last
        
        let location = CLLocationCoordinate2D(latitude: lastPosition.coordinate.latitude, longitude: lastPosition.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.0053, longitudeDelta: 0.0053)
        let zone = MKCoordinateRegion(center: location, span: span)
        newActivityUI.mapView.setRegion(zone, animated: true)

    }
    
}
