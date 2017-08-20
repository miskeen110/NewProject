//
//  UserCollectionViewCell.swift
//  YALLayoutTransitioning
//
//  Created by Roman on 23.02.16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import DisplaySwitcher

private let avatarListLayoutSize: CGFloat = 80.0

class UserCollectionViewCell: UICollectionViewCell, CellInterface {
    
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var backgroundGradientView: UIView!
    @IBOutlet fileprivate weak var nameListLabel: UILabel!
    @IBOutlet fileprivate weak var nameGridLabel: UILabel!
    @IBOutlet weak var statisticLabel: UILabel!
    
    // avatarImageView constraints
    @IBOutlet fileprivate weak var avatarImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var avatarImageViewHeightConstraint: NSLayoutConstraint!
    
    // nameListLabel constraints
    @IBOutlet var nameListLabelLeadingConstraint: NSLayoutConstraint! {
        didSet {
            initialLabelsLeadingConstraintValue = nameListLabelLeadingConstraint.constant
        }
    }
    
    // statisticLabel constraints
    @IBOutlet weak var statisticLabelLeadingConstraint: NSLayoutConstraint!
    
    fileprivate var avatarGridLayoutSize: CGFloat = 0.0
    fileprivate var initialLabelsLeadingConstraintValue: CGFloat = 0.0
    
    func bind(_ projects: Projects) {
        
        
        if projects.logo.isEmpty == false {
            let imageUrl:URL = URL(string: projects.logo)!
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            let image = UIImage(data: imageData as Data)
            avatarImageView.image = image
        }else{
        avatarImageView.image = UIImage(named: "teamwork1.jpg")!
        }

        nameListLabel.text = projects.name
        nameGridLabel.text = projects.name
        let deadLine = self.GetDeadlineFromDateString(DateStr: projects.deadline)
        let deadlineString = (String(deadLine) + " days to deadline ").localized
        statisticLabel.text = deadlineString
    }
    
    func setupGridLayoutConstraints(_ transitionProgress: CGFloat, cellWidth: CGFloat) {
        avatarImageViewHeightConstraint.constant = ceil((cellWidth - avatarListLayoutSize) * transitionProgress + avatarListLayoutSize)
        avatarImageViewWidthConstraint.constant = ceil(avatarImageViewHeightConstraint.constant)
        nameListLabelLeadingConstraint.constant = -avatarImageViewWidthConstraint.constant * transitionProgress + initialLabelsLeadingConstraintValue
        statisticLabelLeadingConstraint.constant = nameListLabelLeadingConstraint.constant
        backgroundGradientView.alpha = transitionProgress <= 0.5 ? 1 - transitionProgress : transitionProgress
        nameListLabel.alpha = 1 - transitionProgress
        statisticLabel.alpha = 1 - transitionProgress
    }
    
    func setupListLayoutConstraints(_ transitionProgress: CGFloat, cellWidth: CGFloat) {
        avatarImageViewHeightConstraint.constant = ceil(avatarGridLayoutSize - (avatarGridLayoutSize - avatarListLayoutSize) * transitionProgress)
        avatarImageViewWidthConstraint.constant = avatarImageViewHeightConstraint.constant 
        nameListLabelLeadingConstraint.constant = avatarImageViewWidthConstraint.constant * transitionProgress + (initialLabelsLeadingConstraintValue - avatarImageViewHeightConstraint.constant)
        statisticLabelLeadingConstraint.constant = nameListLabelLeadingConstraint.constant
        backgroundGradientView.alpha = transitionProgress <= 0.5 ? 1 - transitionProgress : transitionProgress
        nameListLabel.alpha = transitionProgress
        statisticLabel.alpha = transitionProgress
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? DisplaySwitchLayoutAttributes {
            if attributes.transitionProgress > 0 {
                if attributes.layoutState == .grid {
                    setupGridLayoutConstraints(attributes.transitionProgress, cellWidth: attributes.nextLayoutCellFrame.width)
                    avatarGridLayoutSize = attributes.nextLayoutCellFrame.width
                } else {
                    setupListLayoutConstraints(attributes.transitionProgress, cellWidth: attributes.nextLayoutCellFrame.width)
                }
            }
        }
    }
    
    func GetDeadlineFromDateString(DateStr: String)-> Int
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        let dateObj = dateFormatter.date(from: DateStr)
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let calendar = NSCalendar.current
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: dateObj!)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day!
        
    }
    
    
}
