//
//  GradientManagement.swift
//  Walk&Win
//
//  Created by Macbook Air on 17.08.2022.
//

import Foundation
import UIKit

class GradientManagement {
    
    static let shared = GradientManagement()
    
    func setGradient(incomingView: UIView) {
        let currentView = incomingView
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 145/255.0, green: 72.0/255.0, blue: 203/255.0, alpha: 1).cgColor,
            UIColor(red: 34.0/255.0, green: 211/255.0, blue: 198/255.0, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 2]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -0.98, b: 1, c: -1, d: -0.21, tx: 1.48, ty: 0.1))
        gradientLayer.bounds = currentView.bounds.insetBy(dx: -0.5*currentView.bounds.size.width, dy: -0.5*currentView.bounds.size.height)
        gradientLayer.position = currentView.center
        currentView.layer.addSublayer(gradientLayer)
    }

}
