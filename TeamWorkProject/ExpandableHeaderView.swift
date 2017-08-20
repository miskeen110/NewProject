//
//  ExpandableHeaderView.swift
//  TeamWorkProject
//
//  Created by Kaisa Tuononen on 8/20/17.
//  Copyright © 2017 myorg. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegage {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    var delegate: ExpandableHeaderViewDelegage?
    var section: Int!
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer){
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)

    }
    
    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegage){
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
    override   func layoutSubviews() {
        self.layoutSubviews()
        self.textLabel?.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.gray
        
    }

}
