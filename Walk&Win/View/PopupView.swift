//
//  PopupView.swift
//  Walk&Win
//
//  Created by Macbook Air on 17.08.2022.
//

import Foundation
import UIKit

class AddPopUpWindowView: UIView {
    
    //MARK: - popupAddView Variables
    let popupAddView = UIView(frame: CGRect.zero)
    let popupEmailTextField = UITextField(frame: CGRect.zero)
    let popupNickNameTextField = UITextField(frame: CGRect.zero)
    let popupPasswordTextField = UITextField(frame: CGRect.zero)
    let popupSaveButton = UIButton(frame: CGRect.zero)
    let popupCloseButton = UIButton(frame: CGRect.zero)
    let popupInfoLabel = UILabel(frame: CGRect.zero)
    
    //MARK: - popupAddView Variables
    let newActivityPopupAddView = UIView(frame: CGRect.zero)
    let newActivityPopupNameTextField = UITextField(frame: CGRect.zero)
    let newActivityPopupSaveButton = UIButton(frame: CGRect.zero)
    let newActivityPopupCloseButton = UIButton(frame: CGRect.zero)
    let newActivityPopupInfoLabel = UILabel(frame: CGRect.zero)
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Popup Add View (New Dhikr Screen) Layouts
    func openPopupLayout(){
        popupAddView.backgroundColor = UIColor.colorFromHex("#FFFFFF")
        popupAddView.clipsToBounds = false
        popupAddView.layer.cornerRadius = 30

        popupEmailTextField.textColor = UIColor.colorFromHex("#292A2F")
        popupEmailTextField.font = UIFont.systemFont(ofSize: 20, weight: .light)
        popupEmailTextField.alpha = 1
        popupEmailTextField.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        popupEmailTextField.layer.borderWidth = 2
        popupEmailTextField.layer.borderColor = UIColor(red: 0.424, green: 0.501, blue: 0.617, alpha: 0.4).cgColor
        popupEmailTextField.placeholder = "Your email adress"
        popupEmailTextField.layer.cornerRadius = 20
        popupEmailTextField.textAlignment = .center
        popupEmailTextField.keyboardType = .emailAddress
        
        popupNickNameTextField.textColor = UIColor.colorFromHex("#292A2F")
        popupNickNameTextField.font = UIFont.systemFont(ofSize: 20, weight: .light)
        popupNickNameTextField.alpha = 1
        popupNickNameTextField.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        popupNickNameTextField.layer.borderWidth = 2
        popupNickNameTextField.layer.borderColor = UIColor(red: 0.424, green: 0.501, blue: 0.617, alpha: 0.4).cgColor
        popupNickNameTextField.placeholder = "Your Nickname"
        popupNickNameTextField.layer.cornerRadius = 20
        popupNickNameTextField.textAlignment = .center
        
        
        popupPasswordTextField.placeholder = "Password"
        popupPasswordTextField.textColor = UIColor.colorFromHex("#292A2F")
        popupPasswordTextField.font = UIFont.systemFont(ofSize: 20, weight: .light)
        popupPasswordTextField.alpha = 1
        popupPasswordTextField.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        popupPasswordTextField.layer.borderColor = UIColor(red: 0.424, green: 0.501, blue: 0.617, alpha: 0.4).cgColor
        popupPasswordTextField.layer.borderWidth = 2
        popupPasswordTextField.layer.cornerRadius = 20
        popupPasswordTextField.textAlignment = .center
        popupPasswordTextField.isSecureTextEntry = true
        
        

        popupSaveButton.setTitleColor(UIColor.white, for: .normal)
        popupSaveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        popupSaveButton.setTitleColor(UIColor.colorFromHex("#FFFFFF"), for: .normal)
        popupSaveButton.backgroundColor = UIColor.colorFromHex("#25293C")
        popupSaveButton.layer.cornerRadius = 29
        popupSaveButton.setTitle("Sign Up", for: .normal)
        
        popupCloseButton.setImage(UIImage(systemName: "clear.fill"), for: .normal)
        popupCloseButton.tintColor = .black
        
        
        popupInfoLabel.text = "Register"
        popupInfoLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        popupInfoLabel.textColor = UIColor.colorFromHex("#25293C")
        

        popupAddView.addSubview(popupEmailTextField)
        popupAddView.addSubview(popupPasswordTextField)
        popupAddView.addSubview(popupNickNameTextField)
        popupAddView.addSubview(popupSaveButton)
        popupAddView.addSubview(popupCloseButton)
        popupAddView.addSubview(popupInfoLabel)
        addSubview(popupAddView)
        
        popupAddView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, size: .init(width: 325 , height: 402.831))
        popupAddView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        popupAddView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        popupCloseButton.anchor(top: popupAddView.topAnchor, bottom: nil, leading: nil, trailing: popupAddView.trailingAnchor,
                           padding: .init(top: 25, left: 0, bottom: 0, right: 25))
        
        popupInfoLabel.anchor(top: popupAddView.topAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 25, left: 0, bottom: 0, right: 0))
        popupInfoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        popupEmailTextField.anchor(top: popupInfoLabel.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: 275, height: 55))
        popupEmailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        popupPasswordTextField.anchor(top: popupEmailTextField.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: 275, height: 55))
        popupPasswordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        popupNickNameTextField.anchor(top: popupPasswordTextField.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: 275, height: 55))
        popupNickNameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        popupSaveButton.anchor(top: popupNickNameTextField.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 196, height: 53))
        popupSaveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    
    //MARK: - New Activity Layouts
    func newActivityNameLayout(){
        newActivityPopupAddView.backgroundColor = UIColor.colorFromHex("#FFFFFF")
        newActivityPopupAddView.clipsToBounds = false
        newActivityPopupAddView.layer.cornerRadius = 30

        newActivityPopupNameTextField.textColor = UIColor.colorFromHex("#292A2F")
        newActivityPopupNameTextField.font = UIFont.systemFont(ofSize: 20, weight: .light)
        newActivityPopupNameTextField.alpha = 1
        newActivityPopupNameTextField.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        newActivityPopupNameTextField.layer.borderWidth = 2
        newActivityPopupNameTextField.layer.borderColor = UIColor(red: 0.424, green: 0.501, blue: 0.617, alpha: 0.4).cgColor
        newActivityPopupNameTextField.placeholder = "Enter activity name"
        newActivityPopupNameTextField.layer.cornerRadius = 20
        newActivityPopupNameTextField.textAlignment = .center

        newActivityPopupSaveButton.setTitleColor(UIColor.white, for: .normal)
        newActivityPopupSaveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        newActivityPopupSaveButton.setTitleColor(UIColor.colorFromHex("#FFFFFF"), for: .normal)
        newActivityPopupSaveButton.backgroundColor = UIColor.colorFromHex("#25293C")
        newActivityPopupSaveButton.layer.cornerRadius = 29
        newActivityPopupSaveButton.setTitle("Save & Start", for: .normal)
        
        newActivityPopupCloseButton.setImage(UIImage(systemName: "clear.fill"), for: .normal)
        newActivityPopupCloseButton.tintColor = .black
        
        
        newActivityPopupInfoLabel.text = "Start Activity"
        newActivityPopupInfoLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        newActivityPopupInfoLabel.textColor = UIColor.colorFromHex("#25293C")
        

        newActivityPopupAddView.addSubview(newActivityPopupNameTextField)
        newActivityPopupAddView.addSubview(newActivityPopupSaveButton)
        newActivityPopupAddView.addSubview(newActivityPopupCloseButton)
        newActivityPopupAddView.addSubview(newActivityPopupInfoLabel)
        addSubview(newActivityPopupAddView)
        
        newActivityPopupAddView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, size: .init(width: 275 , height: 250))
        newActivityPopupAddView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        newActivityPopupAddView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        newActivityPopupCloseButton.anchor(top: newActivityPopupAddView.topAnchor, bottom: nil, leading: nil, trailing: newActivityPopupAddView.trailingAnchor,
                           padding: .init(top: 25, left: 0, bottom: 0, right: 25))
        
        newActivityPopupInfoLabel.anchor(top: newActivityPopupAddView.topAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 25, left: 0, bottom: 0, right: 0))
        newActivityPopupInfoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        newActivityPopupNameTextField.anchor(top: newActivityPopupInfoLabel.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 35, left: 0, bottom: 0, right: 0) ,size: .init(width: 225, height: 55))
        newActivityPopupNameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        newActivityPopupSaveButton.anchor(top: nil, bottom: newActivityPopupAddView.bottomAnchor, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 20, right: 0), size: .init(width: 150, height: 53))
        newActivityPopupSaveButton.centerXAnchor.constraint(equalTo: newActivityPopupAddView.centerXAnchor).isActive = true
    }
    
}
