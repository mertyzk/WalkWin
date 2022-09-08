//
//  DashboardViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 18.08.2022.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController {
    
    var tableView = UITableView()
    var popularUsersData: [UserModel] = []
    var myActivities: [ActivitiesModel] = []
    var totalTime: Int = 0
    
    lazy var listButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "listmenu")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var nickName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.text = ""
        return label
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .light)
        return label
    }()
    
    lazy var welcomeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, nickName])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "accountcircle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [listButton, welcomeStackView, settingsButton])
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
        stackView.spacing = 5
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
        stackView.spacing = 10
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
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        return label
    }()
    
    lazy var timeNumber: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        return label
    }()
    
    lazy var newActivity: UIButton = {
        let button = UIButton()
        button.setTitle("NEW ACTIVITY", for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        button.backgroundColor = .systemPink
        return button
    }()
    
    lazy var topUsersIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userstar")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var topUsersLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular Users"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    lazy var topUsersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topUsersIcon, topUsersLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loggedInUserControl()
        GradientManagement.shared.setGradient(incomingView: view)
        configTableView()
        addTargetForDashboard()
        setDashboardLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getByDataFromFirebase()
        getTopUsersListFromFirebase()
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
        tableView.alwaysBounceVertical = false
        setTableViewDelegate()
        tableView.register(DashboardCell.self, forCellReuseIdentifier: "dashboardCell")
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
    
    fileprivate func goToNewActivityVC(){
        let goToNewActivity: NewActivityViewController = NewActivityViewController()
        goToNewActivity.modalPresentationStyle = .fullScreen
        goToNewActivity.modalTransitionStyle = .crossDissolve
        self.present(goToNewActivity, animated: true)
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
    

    
    fileprivate func goToLogin(){
        let goToLoginVC: LoginViewController = LoginViewController()
        goToLoginVC.modalPresentationStyle = .fullScreen
        goToLoginVC.modalTransitionStyle = .crossDissolve
        self.present(goToLoginVC, animated: true)
    }
    
    fileprivate func getByDataFromFirebase(){
        guard let currenUserID = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("Users").document(currenUserID).getDocument { snapshot, error in
            if let error = error {
                print("Get data error: ",error)
                return
            }
   
            guard let userData = snapshot?.data() else { return }
            currentUser = UserModel(userData: userData)
            self.welcomeLabel.text = "Hi, \(currentUser?.nickName ?? "Error")"
            
        }
    }
    
    func getTopUsersListFromFirebase(){
        
        Firestore.firestore().collection("Users").order(by: "totalDistance", descending: true).getDocuments { snapshot, fault in
            if let fault = fault {
                print("kullanıcı bilgileri getirilirken hata: \(fault)")
                return
            }
            var userInstance = UserModel()
            for document in snapshot!.documents {
                userInstance.nickName = document.data()["nickName"] as? String
                userInstance.totalDistance = document.data()["totalDistance"] as? Double
                self.popularUsersData.append(userInstance)
            }
            self.tableView.reloadData()
        }
    }
    
    func getDataByFirebase(){
        guard let currenUserID = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("Activities").whereField("UserId", isEqualTo: currenUserID).getDocuments { snapshot, fault in
            if let fault = fault {
                print("kullanıcı bilgileri getirilirken hata: \(fault)")
                return
            }
            var activiyInstance = ActivitiesModel()
            for document in snapshot!.documents {
                guard let _ = document.data()["UserId"] else { return }
                activiyInstance.ActivityTime = document.data()["ActivityTime"] as? Int
                self.myActivities.append(activiyInstance)
                self.totalTime = self.totalTime + (activiyInstance.ActivityTime!)
                let formatTime = String(format: "%.2f", Double(self.totalTime) / 60)
                self.timeNumber.text = "\(formatTime) min"
                self.activityNumber.text = "\(self.myActivities.count)"
            }
        }
    }
    
    fileprivate func loggedInUserControl(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                self.goToLogin()
            }
        }
        return
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
        view.addSubview(topUsersStackView)
        
        topStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 15, bottom: 0, right: 15))
        
        if (screenHeight == 667){
            leftUIView.anchor(top: topStackView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 15, bottom: 0, right: 0), size: .init(width: (185 * screenWidth) / 428 , height: 130))
            
            rightUIView.anchor(top: topStackView.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 15), size: .init(width: (185 * screenWidth) / 428, height: 130))
        } else {
            leftUIView.anchor(top: topStackView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 20, left: 15, bottom: 0, right: 0), size: .init(width: (185 * screenWidth) / 428 , height: 140))
            
            rightUIView.anchor(top: topStackView.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 15), size: .init(width: (185 * screenWidth) / 428, height: 140))
        }
        
        
        
        leftStackView.anchor(top: leftUIView.topAnchor, bottom: nil, leading: leftUIView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        
        rightStackView.anchor(top: rightUIView.topAnchor, bottom: nil, leading: rightUIView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        
        activityNumber.anchor(top: leftStackView.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        activityNumber.centerXAnchor.constraint(equalTo: leftUIView.centerXAnchor).isActive = true
        
        timeNumber.anchor(top: rightStackView.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        timeNumber.centerXAnchor.constraint(equalTo: rightUIView.centerXAnchor).isActive = true
        
        newActivity.anchor(top: leftUIView.bottomAnchor, bottom: nil, leading: leftUIView.leadingAnchor, trailing: rightUIView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        newActivity.heightAnchor.constraint(equalToConstant: ((100 * screenHeight) / 926)).isActive = true
        
        topUsersStackView.anchor(top: newActivity.bottomAnchor, bottom: nil, leading: leftUIView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        tableView.anchor(top: topUsersStackView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: (15 * screenWidth) / 428, bottom: 0, right: (15 * screenWidth) / 428))
    }
    
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch screenHeight {
        case 667: // SE 2nd gen, 8, 7, 6s, 6
            if (popularUsersData.count > 7){
                return 7
            } else {
                return popularUsersData.count
            }
        case 844: // 13, 13 pro, 12, 12 pro
            if (popularUsersData.count > 9){
                return 9
            } else {
                return popularUsersData.count
            }
        case 812: // 13 mini, 12 mini, 11 pro, xs, x
            if (popularUsersData.count > 8){
                return 8
            } else {
                return popularUsersData.count
            }
        case 896: // 11 pro max, 11, xr, xs max
            if (popularUsersData.count > 10){
                return 10
            } else {
                return popularUsersData.count
            }
        case 736: // 8 plus
            if (popularUsersData.count > 8){
                return 8
            } else {
                return popularUsersData.count
            }
        case 926: // 13 pro max - 12 pro max
            if (popularUsersData.count > 10){
                return 10
            } else {
                return popularUsersData.count
            }
        default:
            if (popularUsersData.count > 10){
                return 10
            } else {
                return popularUsersData.count
            }
        }
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardCell", for: indexPath) as! DashboardCell
        let data = popularUsersData[indexPath.row]
        cell.setGenerate(item: data)
        cell.sequence.text = String(indexPath.row + 1) + "."
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        45
    }
    
}
