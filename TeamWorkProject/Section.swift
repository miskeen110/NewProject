//
//  Section.swift
//  TableViewDropDown
//
//  Created by BriefOS on 5/3/17.
//  Copyright © 2017 BriefOS. All rights reserved.
//

import Foundation

struct Section {
    var heading: String!
    var details: [String]!
    var expanded: Bool!
    
    init(heading: String, details: [String], expanded: Bool) {
        self.heading = heading
        self.details = details
        self.expanded = expanded
    }
}
