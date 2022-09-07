//
//  HistoryCell.swift
//  Walk&Win
//
//  Created by Macbook Air on 19.08.2022.
//

import UIKit
import Firebase

protocol CellDelegate: AnyObject {
    func activityDetailsButtonTapped(cell: HistoryCell)
    func activityDeleteButtonTapped(cell: HistoryCell)
}

class HistoryCell: UITableViewCell {
    
    weak var delegate: CellDelegate?
    
    lazy var leftCornerTopCell: UIView = {
        let cellView = UIView()
        cellView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cellView.alpha = 0.4
        cellView.layer.cornerRadius = 10
        cellView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return cellView
    }()
    
    lazy var rightCornerTopCell: UIView = {
        let cellView = UIView()
        cellView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cellView.alpha = 0.2
        cellView.layer.cornerRadius = 10
        cellView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return cellView
    }()
    
    lazy var bottomCell: UIView = {
        let cellView = UIView()
        cellView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cellView.alpha = 0.6
        cellView.layer.cornerRadius = 10
        cellView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return cellView
    }()
    
    lazy var rightCornerBottomCell: UIView = {
        let cellView = UIView()
        cellView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cellView.alpha = 0.6
        cellView.layer.cornerRadius = 10
        cellView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return cellView
    }()
    
    lazy var activityName: UILabel = {
        let label = UILabel()
        label.text = "Başlık"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var activityDate: UILabel = {
        let label = UILabel()
        label.text = "Goal: 99"
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.alpha = 0.5
        return label
    }()
    
    lazy var activityDistance: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    lazy var activityDetailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Activity Details", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(activityDetailsButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(activityDeleteButtonClicked), for: .touchUpInside)
        return button
    }()
    
    func setGenerate(item: Activities) {
        activityName.text = item.ActivityName
        let meterToKilometer = item.ActivityDistance! / 1000
        let convertMeterToKilomet = String(format: "%.2f", meterToKilometer)
        activityDistance.text = "\(convertMeterToKilomet) km"
        let formatActivityTime = item.ActivityDate!
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+3")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy / HH:mm"
        let strDate = dateFormatter.string(from: formatActivityTime.dateValue())
        activityDate.text = strDate
    }
    
    @objc func activityDetailsButtonClicked(){
        delegate?.activityDetailsButtonTapped(cell: self)
    }
    
    @objc func activityDeleteButtonClicked(){
        delegate?.activityDeleteButtonTapped(cell: self)
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "historyCell")
        
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
        contentView.addSubview(leftCornerTopCell)
        contentView.addSubview(rightCornerTopCell)
        contentView.addSubview(bottomCell)
        contentView.addSubview(activityName)
        contentView.addSubview(activityDate)
        contentView.addSubview(activityDetailsButton)
        contentView.addSubview(activityDistance)
        contentView.addSubview(rightCornerBottomCell)
        contentView.addSubview(deleteButton)
        
        
        leftCornerTopCell.anchor(top: nil, bottom: nil, leading: nil, trailing: nil,
                                 padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                                 size: .init(width: ((254 * screenWidth) / 428), height: 73))
        
        
        rightCornerTopCell.anchor(top: leftCornerTopCell.topAnchor, bottom: nil, leading: leftCornerTopCell.trailingAnchor, trailing: nil,
                                  padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                                  size: .init(width: ((117 * screenWidth) / 428), height: 73))
        
        
        bottomCell.anchor(top: leftCornerTopCell.bottomAnchor, bottom: nil, leading: leftCornerTopCell.leadingAnchor, trailing: rightCornerTopCell.leadingAnchor,
                          padding: .init(top: 0, left: 25, bottom: 0, right: 25))
        
        rightCornerBottomCell.anchor(top: rightCornerTopCell.bottomAnchor, bottom: nil, leading: rightCornerTopCell.leadingAnchor, trailing: rightCornerTopCell.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15))
    
        activityName.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: nil,
                            padding: .init(top: 10, left: 14, bottom: 0, right: 0))
        
        
        activityDate.anchor(top: activityName.bottomAnchor, bottom: nil, leading: activityName.leadingAnchor, trailing: nil,
                            padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        
        
        activityDetailsButton.anchor(top: bottomCell.topAnchor, bottom: nil, leading: bottomCell.leadingAnchor, trailing: bottomCell.trailingAnchor,
                                     padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        activityDetailsButton.centerYAnchor.constraint(equalTo: bottomCell.centerYAnchor).isActive = true
        
        deleteButton.anchor(top: rightCornerBottomCell.topAnchor, bottom: nil, leading: rightCornerBottomCell.leadingAnchor, trailing: rightCornerBottomCell.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        deleteButton.centerYAnchor.constraint(equalTo: rightCornerBottomCell.centerYAnchor).isActive = true
        
        
        activityDistance.anchor(top: rightCornerTopCell.topAnchor, bottom: nil, leading: rightCornerTopCell.leadingAnchor, trailing: rightCornerTopCell.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        activityDistance.centerYAnchor.constraint(equalTo: rightCornerTopCell.centerYAnchor).isActive = true
        
        
    }

}
