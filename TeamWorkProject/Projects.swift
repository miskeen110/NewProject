//
//  Projects.swift
//  TeamWorkProject
//
//  Created by Miskeen Jatoi on 8/20/17.
//  Copyright © 2017 myorg. All rights reserved.
//

/*This class arranges the data into format of the class so it can be called and get appropriated values*/
import UIKit

class Projects {
    
    var name: String
    var deadline: String
    var logo: String
    var description:String
    var companyName: String
    var companyId: String
    var startDate: String
    var projectId: String
    var createdOn: String
    var lastChangedOn:String

    init(name: String, deadline: String, logo: String,description:String, companyName: String, companyId: String,
         startDate: String, projectId: String, lastChangedOn: String, createdOn: String) {
        self.name = name
        self.deadline = deadline
        self.logo = logo
        self.description = description
        self.companyName = companyName
        self.companyId = companyId
        self.startDate = startDate
        self.projectId = projectId
        self.lastChangedOn = lastChangedOn
        self.createdOn = createdOn
       
    }
    
}
