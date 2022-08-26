//
//  LoginViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 17.08.2022.
//

import UIKit
import Firebase
import JGProgressHUD

class LoginViewController: UIViewController {
    
    lazy var logoArea: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "25yillogo")?.withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        button.layer.cornerRadius = 25
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter e-mail adress"
        textField.keyboardType = .emailAddress
        textField.textAlignment = .center
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter password"
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    lazy var memberTextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Didn't have an account?\nClick here to register", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 15
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        GradientManagement.shared.setGradient(incomingView: view)
        setLayout()
        addTargetForLoginVC()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    fileprivate lazy var screenHeight = view.frame.size.height
    fileprivate lazy var screenWidth = view.frame.size.width
    func setLayout(){
        view.addSubview(logoArea)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(memberTextButton)
        
        logoArea.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: ((225 * screenHeight) / 926), left: 0, bottom: 0, right: 0), size: .init(width: 339.772, height: 65))
        logoArea.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        emailTextField.anchor(top: logoArea.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: ((100 * screenHeight) / 926), left: 0, bottom: 0, right: 0), size: .init(width: 275, height: 45))
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: ((25 * screenHeight) / 926), left: 0, bottom: 0, right: 0), size: .init(width: 275, height: 45))
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        loginButton.anchor(top: passwordTextField.bottomAnchor, bottom: nil, leading: passwordTextField.leadingAnchor, trailing: passwordTextField.trailingAnchor, padding: .init(top: ((25 * screenHeight) / 926), left: 0, bottom: 0, right: 0))
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        memberTextButton.anchor(top: loginButton.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: ((25 * screenHeight) / 926), left: 0, bottom: 0, right: 0))
        memberTextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    fileprivate func addTargetForLoginVC(){
        memberTextButton.addTarget(self, action: #selector(memberTextButtonClicked), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    @objc func memberTextButtonClicked(){
        let goToPopup: PopUpWindow = PopUpWindow()
        goToPopup.popUpWindowView.openPopupLayout()
        self.present(goToPopup, animated: true, completion: nil)
    }
    
    @objc func loginButtonPressed(){
        
        guard let emailAdress = emailTextField.text, let password = passwordTextField.text else { return }
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Logging in..."
        hud.show(in: self.view)
        
        Auth.auth().signIn(withEmail: emailAdress, password: password) { result, error in
            if error != nil {
                hud.dismiss(animated: false)
                let alert = UIAlertController(title: "Sign In Error!", message: "Login failed", preferredStyle: .alert)
                self.present(alert, animated: true)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    alert.dismiss(animated: true)
                }))
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.goToHomepage()
            }
        }
    }
    
    fileprivate func goToHomepage(){
        let goToHomepage: DashboardViewController = DashboardViewController()
        goToHomepage.modalPresentationStyle = .fullScreen
        goToHomepage.modalTransitionStyle = .crossDissolve
        self.present(goToHomepage, animated: true)
    }

}
