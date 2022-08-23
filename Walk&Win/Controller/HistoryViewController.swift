//
//  HistoryViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 18.08.2022.
//

import UIKit

struct MyActivityData{
    var activityName : String?
    var activityDate : String?
    var activityDistance : String?
}

class HistoryViewController: UIViewController {
    
    let tableView = UITableView()
    
    var arrayData: [MyActivityData] = [MyActivityData(activityName: "Güvenpark", activityDate: "19/08/2022", activityDistance: "3"),
                                         MyActivityData(activityName: "Abdi İpekçi Parkı", activityDate: "15/08/2022", activityDistance: "5.5"),
                                     MyActivityData(activityName: "Kurtuluş Parkı", activityDate: "08/08/2022", activityDistance: "8"),
                                     MyActivityData(activityName: "Mogan Gölü", activityDate: "19/07/2022", activityDistance: "11"),
                                     MyActivityData(activityName: "Göksupark", activityDate: "05/07/2022", activityDistance: "10"),
                                     MyActivityData(activityName: "Mavigöl", activityDate: "28/06/2022", activityDistance: "9"),
                                     MyActivityData(activityName: "Eymir Gölü", activityDate: "11/06/2022", activityDistance: "24")]

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
    
    fileprivate func addTargetForHistory(){
        goBackHome.addTarget(self, action: #selector(goBackHomeClicked), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonClicked), for: .touchUpInside)
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
        return arrayData.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        cell.delegate = self
        cell.setGenerate(item: arrayData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
     }
}

extension HistoryViewController: CellDelegate {
    func activityDetailsButtonTapped(cell: HistoryCell) {
        let goToActivityDetailVC: ActivityDetailsViewController = ActivityDetailsViewController()
        goToActivityDetailVC.modalPresentationStyle = .fullScreen
        goToActivityDetailVC.modalTransitionStyle = .crossDissolve
        self.present(goToActivityDetailVC, animated: true, completion: nil)
    }
    
    
}
