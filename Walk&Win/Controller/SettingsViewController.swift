//
//  SettingsViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 18.08.2022.
//

import UIKit
import Firebase
import JGProgressHUD

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
    
    lazy var eMailArea: UILabel = {
        let label = UILabel()
        label.text = "E-mail"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: 45).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.clipsToBounds = true
        return label
    }()
    
    lazy var eMailInfoTextLabel: UILabel = {
        let label = UILabel()
        label.text = "\(currentUser?.emailAdress ?? "Error")"
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: 45).isActive = true
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var emailStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eMailArea, eMailInfoTextLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var nicknameArea: UILabel = {
        let label = UILabel()
        label.text = "Nick"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: 45).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.clipsToBounds = true
        return label
    }()
    
    lazy var nicknameTextField: UITextField = {
        let nicknameTextField = UITextField()
        nicknameTextField.attributedPlaceholder = NSAttributedString(
            string: "\(currentUser?.nickName ?? "Error")",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        nicknameTextField.textColor = .white
        nicknameTextField.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        nicknameTextField.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        nicknameTextField.layer.cornerRadius = 10
        nicknameTextField.textAlignment = .center
        nicknameTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        nicknameTextField.clipsToBounds = true
        return nicknameTextField
    }()
    
    lazy var nickNameStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nicknameArea, nicknameTextField])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var passwordArea: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: 45).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.clipsToBounds = true
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let nicknameTextField = UITextField()
        nicknameTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter a new password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        nicknameTextField.textColor = .black
        nicknameTextField.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        nicknameTextField.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        nicknameTextField.layer.cornerRadius = 10
        nicknameTextField.textAlignment = .center
        nicknameTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        nicknameTextField.clipsToBounds = true
        nicknameTextField.isSecureTextEntry = true
        return nicknameTextField
    }()
    
    lazy var passwordStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordArea, passwordTextField])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save The New Settings", for: .normal)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return button
    }()
    
    lazy var infoAreaStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailStackView, nickNameStackView, passwordStackView, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 25
        return stackView
    }()
    

    
    fileprivate lazy var screenHeight = view.frame.size.height
    fileprivate lazy var screenWidth = view.frame.size.width
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
        view.addSubview(infoAreaStackView)
        
        goBackHome.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, padding: .init(top: 5, left: 15, bottom: 0, right: 0))
        topLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
        exitButton.anchor(top: nil, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        exitButton.centerYAnchor.constraint(equalTo: goBackHome.centerYAnchor).isActive = true
        
        infoAreaStackView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: (125 * screenHeight / 926), left: (15 * screenWidth / 428), bottom: 0, right: (15 * screenWidth / 428)))
    }
    
    fileprivate func addTargetForSettings(){
        goBackHome.addTarget(self, action: #selector(goBackHomeClicked), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonClicked), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    @objc fileprivate func goBackHomeClicked(){
        goToHomepage()
    }
    
    @objc fileprivate func exitButtonClicked(){
        let alert = UIAlertController(title: "Logging Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
            guard let _ = Auth.auth().currentUser?.uid else { return }
            do {
                try Auth.auth().signOut()
            } catch let signOutError {
                print("Sign out error: ", signOutError)
            }
            let logoutHud = JGProgressHUD(style: .dark)
            logoutHud.textLabel.text = "Logging out.."
            logoutHud.show(in: self.view)
            logoutHud.dismiss(afterDelay: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.goToLogin()
            }

        }))
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    @objc fileprivate func saveButtonClicked(){
        
    }
    
    fileprivate func goToHomepage(){
        let goToHomepage: DashboardViewController = DashboardViewController()
        goToHomepage.modalPresentationStyle = .fullScreen
        goToHomepage.modalTransitionStyle = .crossDissolve
        self.present(goToHomepage, animated: true)
    }
    
    fileprivate func goToLogin(){
        let goToLoginVC: LoginViewController = LoginViewController()
        goToLoginVC.modalPresentationStyle = .fullScreen
        goToLoginVC.modalTransitionStyle = .crossDissolve
        self.present(goToLoginVC, animated: true)
    }

}
