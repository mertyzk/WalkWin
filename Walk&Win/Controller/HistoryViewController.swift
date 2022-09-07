//
//  HistoryViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 18.08.2022.
//

import UIKit
import CoreLocation
import Firebase

class HistoryViewController: UIViewController {
    
    let tableView = UITableView()
    
    var myActivities: [Activities] = []
    
    var geoPoint: GeoPoint?
    
    var documentIds: [String] = []
    
    fileprivate var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()

    lazy var goBackHome: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gohome")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Activity History"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargetForHistory()
        GradientManagement.shared.setGradient(incomingView: view)
        configTableView()
        setToHistoryVCLayout()
        getDataByFirebase()
    }
    
    func setTableViewDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func configTableView(){
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        setTableViewDelegate()
        tableView.register(HistoryCell.self, forCellReuseIdentifier: "historyCell")
    }
    
    func getDataByFirebase(){
        Firestore.firestore().collection("Activities").whereField("UserId", isEqualTo: currentUser!.userID).getDocuments { snapshot, fault in
            if let fault = fault {
                print("kullanıcı bilgileri getirilirken hata: \(fault)")
                return
            }
            //guard let incomingData = snapshot?.documents else { return }
            var activiyInstance = Activities()
            for document in snapshot!.documents {
                guard let _ = document.data()["UserId"] else { return }
                activiyInstance.ActivityName = document.data()["ActivityName"] as? String
                activiyInstance.ActivityDate = document.data()["ActivityDate"] as? Timestamp
                activiyInstance.ActivityDistance = document.data()["ActivityDistance"] as? Double
                activiyInstance.ActivityTime = document.data()["ActivityTime"] as? Int
                activiyInstance.ActivityVelocity = document.data()["ActivityVelocity"] as? Double
                activiyInstance.ActivityPoints = document.data()["ActivityPoints"] as? [GeoPoint]
                self.myActivities.append(activiyInstance)
                self.documentIds.append(document.documentID)
            }
            self.tableView.reloadData()
        }
    }
    
    lazy var screenHeight = view.frame.size.height
    lazy var screenWidth = view.frame.size.width
    fileprivate func setToHistoryVCLayout(){
        view.addSubview(goBackHome)
        view.addSubview(topLabel)
        view.addSubview(settingsButton)
        goBackHome.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 5, left: 15, bottom: 0, right: 0))
        topLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil)
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
        settingsButton.anchor(top: nil, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        settingsButton.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
        tableView.anchor(top: settingsButton.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,
                                 padding: .init(top: ((30 * screenHeight) / 926), left: (27 * screenWidth) / 428, bottom: 20, right: (27 * screenWidth) / 428))
    }
    
    func addTargetForHistory(){
        goBackHome.addTarget(self, action: #selector(goBackHomeClicked), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonClicked), for: .touchUpInside)
    }
    
    @objc func catchDeleteData(){
        getDataByFirebase()
    }
    
    @objc fileprivate func settingsButtonClicked(){
        let goToSettings: SettingsViewController = SettingsViewController()
        goToSettings.modalPresentationStyle = .fullScreen
        goToSettings.modalTransitionStyle = .crossDissolve
        self.present(goToSettings, animated: true)
    }
    
    @objc fileprivate func goBackHomeClicked(){
        goToHomepage()
    }
    
    @objc fileprivate func goActivityDetailsClicked(){
        goToActivityDetailsClicked()
    }
    
    fileprivate func goToHomepage(){
        let goToHomepage: DashboardViewController = DashboardViewController()
        goToHomepage.modalPresentationStyle = .fullScreen
        goToHomepage.modalTransitionStyle = .crossDissolve
        self.present(goToHomepage, animated: true)
    }
    
    fileprivate func goToActivityDetailsClicked(){
        let goToActivityDetail: ActivityDetailsViewController = ActivityDetailsViewController()
        goToActivityDetail.modalPresentationStyle = .fullScreen
        goToActivityDetail.modalTransitionStyle = .partialCurl
        self.present(goToActivityDetail, animated: true)
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myActivities.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        cell.delegate = self
        let data = myActivities[indexPath.row]
        cell.setGenerate(item: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
     }
}

extension HistoryViewController: CellDelegate {
    func activityDetailsButtonTapped(cell: HistoryCell) {
        guard let index = self.tableView.indexPath(for: cell) else { return }
        let data = myActivities[index.row]
        let goToActivityDetailVC: ActivityDetailsViewController = ActivityDetailsViewController()
        goToActivityDetailVC.modalPresentationStyle = .fullScreen
        goToActivityDetailVC.modalTransitionStyle = .crossDissolve
        if let distance = cell.activityDistance.text, let name = cell.activityName.text {
            goToActivityDetailVC.activityNameLabel.text = name
            goToActivityDetailVC.distanceLabel.text = distance
            let stringVelocity = String(format: "%.1f", data.ActivityVelocity ?? "0.0 m/s")
            goToActivityDetailVC.velocityLabel.text = "\(stringVelocity) m/s"
            print(data.ActivityTime!)
            let formatTime = String(format: "%.2f", Double(data.ActivityTime!) / 60)
            goToActivityDetailVC.timeLabel.text = "\(formatTime) min"
            goToActivityDetailVC.incomingPointsArray = data.ActivityPoints!

        }
        self.present(goToActivityDetailVC, animated: true, completion: nil)
    }
    
    func activityDeleteButtonTapped(cell: HistoryCell) {
        guard let index = self.tableView.indexPath(for: cell) else { return }
        let data = documentIds[index.row]
        
        let alert = UIAlertController(title: "Delete Activity", message: "Are you sure you want to delete the activity?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
            Firestore.firestore().collection("Activities").document(data).delete()
            self.myActivities = []
            self.getDataByFirebase()
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true)
        }))
        tableView.reloadData()
        self.present(alert, animated: true)
    }
        
    
    
}
