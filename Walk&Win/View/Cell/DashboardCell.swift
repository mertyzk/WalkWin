//
//  DashboardCell.swift
//  Walk&Win
//
//  Created by Macbook Air on 19.08.2022.
//

import UIKit

class DashboardCell: UITableViewCell {
    
    lazy var leftArea: UIView = {
        let cellView = UIView()
        cellView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cellView.alpha = 0.7
        cellView.layer.cornerRadius = 10
        cellView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return cellView
    }()
    
    lazy var midArea: UIView = {
        let cellView = UIView()
        cellView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cellView.alpha = 0.45
        return cellView
    }()
    
    
    lazy var rightArea: UIView = {
        let cellView = UIView()
        cellView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cellView.alpha = 0.3
        cellView.layer.cornerRadius = 10
        cellView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return cellView
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "Başlık"
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var sequence: UILabel = {
        let label = UILabel()
        label.text = "1."
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var totalDistance: UILabel = {
        let label = UILabel()
        label.text = "1275 m"
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    
    func setGenerate(item: UserModel) {
        userName.text = item.nickName
        let convertTo2f = String(format: "%.2f", item.totalDistance ?? 0.0)
        totalDistance.text = "\(convertTo2f)m"
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "dashboardCell")
        
    }
    
    override func layoutSubviews() {
        inProgressCellLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var screenHeight = UIScreen.main.bounds.height
    lazy var screenWidth = UIScreen.main.bounds.width
    
    func inProgressCellLayout(){
        
        contentView.addSubview(leftArea)
        contentView.addSubview(midArea)
        contentView.addSubview(rightArea)
        contentView.addSubview(userName)
        contentView.addSubview(totalDistance)
        contentView.addSubview(sequence)
        
        
        
        leftArea.anchor(top: nil, bottom: nil, leading: self.leadingAnchor, trailing: nil,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                        size: .init(width: 45, height: 36))
        

        midArea.anchor(top: leftArea.topAnchor, bottom: leftArea.bottomAnchor, leading: leftArea.trailingAnchor, trailing: nil,
                         padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        

        rightArea.anchor(top: midArea.topAnchor, bottom: midArea.bottomAnchor, leading: midArea.trailingAnchor, trailing: self.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: (145 * screenWidth / 428), height: 36))
        

        userName.anchor(top: nil, bottom: nil, leading: midArea.leadingAnchor, trailing: nil,
                        padding: .init(top: 0, left: 15, bottom: 0, right: 0))
        userName.centerYAnchor.constraint(equalTo: midArea.centerYAnchor).isActive = true
        

        totalDistance.anchor(top: nil, bottom: nil, leading: nil, trailing: nil)
        totalDistance.centerYAnchor.constraint(equalTo: rightArea.centerYAnchor).isActive = true
        totalDistance.centerXAnchor.constraint(equalTo: rightArea.centerXAnchor).isActive = true
        
        sequence.anchor(top: nil, bottom: nil, leading: nil, trailing: nil)
        sequence.centerXAnchor.constraint(equalTo: leftArea.centerXAnchor).isActive = true
        sequence.centerYAnchor.constraint(equalTo: leftArea.centerYAnchor).isActive = true
        
        
    }
    
}
