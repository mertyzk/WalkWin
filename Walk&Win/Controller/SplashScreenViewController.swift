//
//  SplashScreenViewController.swift
//  Walk&Win
//
//  Created by Macbook Air on 17.08.2022.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "transparentlogo")?.withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    
    lazy var poweredLabel: UILabel = {
        let label = UILabel()
        label.text = "Winning has never been this easy..."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 19, weight: .light)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        GradientManagement.shared.setGradient(incomingView: view)
        setSplashScreenLayout()
    }
    
    fileprivate lazy var screenHeight = view.frame.size.height
    fileprivate lazy var screenWidth = view.frame.size.width
    fileprivate func setSplashScreenLayout(){
        view.addSubview(imageView)
        view.addSubview(poweredLabel)
        
        switch screenHeight {
        case 667:
            imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: ((140 * screenHeight) / 926), left: 0, bottom: 0, right: 0) , size: .init(width: 350, height: 350))
        case 844:
            imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: ((165 * screenHeight) / 926), left: 0, bottom: 0, right: 0) , size: .init(width: 350, height: 350))
        case 812:
            imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: ((155 * screenHeight) / 926), left: 0, bottom: 0, right: 0) , size: .init(width: 350, height: 350))
        case 896:
            imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: ((175 * screenHeight) / 926), left: 0, bottom: 0, right: 0) , size: .init(width: 350, height: 350))
        case 736:
            imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: ((150 * screenHeight) / 926), left: 0, bottom: 0, right: 0) , size: .init(width: 350, height: 350))
        default:
            imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: ((200 * screenHeight) / 926), left: 0, bottom: 0, right: 0) , size: .init(width: 350, height: 350))
        }
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        poweredLabel.anchor(top: imageView.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        poweredLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        asyncAfterGoToMainVC()
    }
    
    fileprivate func asyncAfterGoToMainVC(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .flipHorizontal
            self.present(loginVC, animated: true)
        }
    }


}
