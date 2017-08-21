//
//  Section.swift
//  TeamWorkProject
//
//  Created by Miskeen Jatoi on 8/20/17.
//  Copyright © 2017 myorg. All rights reserved.
//

import Foundation

            /**************This struct defines the tableview headers ,its details
                            as well as expandable feature boolean***************/
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
