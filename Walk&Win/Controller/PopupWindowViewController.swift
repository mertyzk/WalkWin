//
//  PopupWindowViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 17.08.2022.
//

import Foundation
import UIKit
import Firebase
import JGProgressHUD
import FirebaseFirestore

class PopUpWindow: UIViewController {
    
    let popUpWindowView = AddPopUpWindowView()
    let registerHud = JGProgressHUD(style: .dark)
    var dashboardVC = DashboardViewController()
    let newActivityVC = NewActivityViewController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        popUpWindowView.popupSaveButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        popUpWindowView.popupCloseButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        popUpWindowView.popupEmailTextField.addTarget(self, action: #selector(checkDataChange), for: .editingChanged)
        popUpWindowView.popupPasswordTextField.addTarget(self, action: #selector(checkDataChange), for: .editingChanged)
        popUpWindowView.popupNickNameTextField.addTarget(self, action: #selector(checkDataChange), for: .editingChanged)
        popUpWindowView.newActivityPopupSaveButton.addTarget(self, action: #selector(soyle), for: .touchUpInside)
        
        view = popUpWindowView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func closeButtonClicked(){
        dismiss(animated: true)
    }
    
    @objc func activitySaveButtonClicked(){
        dismiss(animated: true)
        
    }
    
    @objc func soyle(){
        NotificationCenter.default.post(name: NSNotification.Name("dinleyen"), object: nil)
    }
    
    
    fileprivate func goToDashboard(){
        let goToDashboardVC = DashboardViewController()
        goToDashboardVC.modalPresentationStyle = .fullScreen
        goToDashboardVC.modalTransitionStyle = .crossDissolve
        present(goToDashboardVC, animated: true)
    }

    @objc func registerButtonClicked(){
        guard let emailAdress = popUpWindowView.popupEmailTextField.text, let nickname = popUpWindowView.popupNickNameTextField.text, let password = popUpWindowView.popupPasswordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: emailAdress, password: password) { result, error in
            if let error = error {
                self.errorInfoJGHud(error: error)
                return
            } else {
                guard let userID = result?.user.uid else { return }
                let setData = ["UserName" : nickname, "UserID" : userID, "EmailAdress" : emailAdress]
                Firestore.firestore().collection("Users").document(userID).setData(setData) { (error) in
                    if let error = error {
                        print("Error occurred while saving data", error)
                        return
                    }
                    print("Save data success")
                }
                self.registerHud.textLabel.text = "Registering..."
                self.registerHud.show(in: self.view)
                self.registerHud.dismiss(afterDelay: 1, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let alert = UIAlertController(title: "Register Success!", message: "Signing...", preferredStyle: .alert)
                    self.present(alert, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        alert.dismiss(animated: true)
                        self.goToDashboard()
                    }
                }
            }
            
        }
        
    }
    
    fileprivate func errorInfoJGHud(error: Error){
        let errorHud = JGProgressHUD(style: .dark)
        errorHud.textLabel.text = "Register failed"
        errorHud.detailTextLabel.text = error.localizedDescription
        errorHud.show(in: self.view)
        errorHud.dismiss(afterDelay: 2.5, animated: true)
    }
    
    @objc func checkDataChange(){
        
        let dataValidation = (popUpWindowView.popupEmailTextField.text?.count ?? 0) > 0 && (popUpWindowView.popupNickNameTextField.text?.count ?? 0) > 0 && (popUpWindowView.popupPasswordTextField.text?.count ?? 0) > 0
        
        if dataValidation {
            popUpWindowView.popupSaveButton.isEnabled = true
            popUpWindowView.popupSaveButton.isUserInteractionEnabled = true
            popUpWindowView.popupSaveButton.backgroundColor = #colorLiteral(red: 0.3989983499, green: 0.1973582506, blue: 0.5560989976, alpha: 1)
            popUpWindowView.popupSaveButton.setTitleColor(UIColor.colorFromHex("#FFFFFF"), for: .normal)
        } else {
            popUpWindowView.popupSaveButton.isEnabled = false
            popUpWindowView.popupSaveButton.isUserInteractionEnabled = false
            popUpWindowView.popupSaveButton.setTitleColor(UIColor.colorFromHex("#ded8d8"), for: .normal)
            popUpWindowView.popupSaveButton.backgroundColor = UIColor.colorFromHex("#9b9ba4")
        }
        
    }
    
    
}
