//
//  PopupWindowViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 17.08.2022.
//

import Foundation
import UIKit

class PopUpWindow: UIViewController {
    
    let popUpWindowView = AddPopUpWindowView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        popUpWindowView.popupSaveButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        popUpWindowView.popupCloseButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
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
    
    @objc func successCloseButtonClicked()
    {
        
    }
    
    /*fileprivate func goToHomePage(){
        let goToHomepageVC = HomepageViewController()
        goToHomepageVC.modalPresentationStyle = .fullScreen
        goToHomepageVC.modalTransitionStyle = .crossDissolve
        present(goToHomepageVC, animated: true)
    }*/

    
    @objc func registerButtonClicked(){
        
    }
    
    
}
