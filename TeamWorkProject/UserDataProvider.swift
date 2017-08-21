//
//  UserDataProvider.swift
//  TeamWorkProject
//
//  Created by Miskeen Jatoi on 8/20/17.
//  Copyright © 2017 myorg. All rights reserved.
//

/*This class is responsible for getting data from API */
import UIKit
import Alamofire


class UserDataProvider {
    
     var projects = [Projects]()
     fileprivate let serverURL = "https://yat.teamwork.com/projects.json"
    
    func generateDataFromAPI() -> [Projects] {

        let user = "twp_TEbBXGCnvl2HfvXWfkLUlzx92e3T"
        let password = "yatyatyat27"
        let credential = URLCredential(user: user, password: password, persistence: .forSession)
        
        /*Alamofire library helps in json downloading arranging if something missing*/
        Alamofire.request("https://yat.teamwork.com/projects.json/\(user)/\(password)")
            .authenticate(usingCredential: credential)
            .responseJSON { response in
                
                if let json = response.result.value as! NSDictionary? {
                    
                   let projects = json["projects"] as? [[String: Any]] ?? []
                    
                    for index in 0...projects.count-1 {
                        
                        let aObject = projects[index] as [String : AnyObject]
                        let name = aObject["name"] as! String
                        let deadLine = aObject["endDate"] as! String
                        let logo = aObject["logo"] as! String
                        let description = aObject["description"] as! String
                        let startDate = aObject["startDate"] as! String
                        let projectId = aObject["id"] as! String
                        let lastChangedOn = aObject["last-changed-on"] as! String
                        let createdOn = aObject["created-on"] as! String
                        let company = aObject["company"] as? [String: Any]
                        let companyName = company?["name"] as? String
                        let companyId = company?["id"] as? String
     
                        let project = Projects(name: name, deadline:deadLine, logo:logo, description: description,
                                               companyName:companyName!,companyId: companyId!,startDate: startDate,
                                               projectId:projectId, lastChangedOn: lastChangedOn, createdOn:createdOn)
                        
                            self.projects.append(project)
                        }
                    }
                    else
                    {
                    print("Did not receive json")
                    }
            }
        /*Without this code until response comes this class will return nil*/
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while self.projects.isEmpty

        
        return self.projects
    }
    

        
    
    }
    
