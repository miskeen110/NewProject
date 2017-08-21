//
//  UserDataProvider.swift
//  YALLayoutTransitioning
//
//  Created by Roman on 02.03.16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import Alamofire

let serverURL = "https://yat.teamwork.com/projects.json"
class UserDataProvider {
    
     var projects = [Projects]()
    var names: [String] = []
    var id: [String] = []
    
    func generateFakeUsers() -> [Projects] {

        /*let user1 = User(name: "Jack", surname: "Hoggarth", avatar:UIImage(named: "placeholder1")!, postsCount: 300, commentsCount: 600, likesCount: 1000)
        let user2 = User(name: "Mike", surname: "Holiday", avatar: UIImage(named: "placeholder2")!, postsCount: 25, commentsCount: 40, likesCount: 111)
        let user3 = User(name: "Tom", surname: "Jerome", avatar: UIImage(named: "placeholder3")!, postsCount: 13, commentsCount: 145, likesCount: 78)
        let user4 = User(name: "Leo", surname: "Nicholson", avatar: UIImage(named: "placeholder4")!, postsCount: 34, commentsCount: 234, likesCount: 76)
        let user5 = User(name: "Grase", surname: "Kendal", avatar: UIImage(named: "placeholder5")!, postsCount: 6, commentsCount: 87, likesCount: 23)
        let user6 = User(name: "Marry", surname: "Kennedy", avatar: UIImage(named: "placeholder6")!, postsCount: 12, commentsCount: 5, likesCount: 45)
        let user7 = User(name: "Monica", surname: "Lamberts", avatar: UIImage(named: "placeholder7")!, postsCount: 34, commentsCount: 543, likesCount: 12)
        let user8 = User(name: "Ann", surname: "Mason", avatar: UIImage(named: "placeholder8")!, postsCount: 1, commentsCount: 2, likesCount: 4)
        let user9 = User(name: "Adam", surname: "MacDonald", avatar: UIImage(named: "placeholder9")!, postsCount: 34, commentsCount: 345, likesCount: 67)
        let user10 = User(name: "Mayro", surname: "Nathan", avatar: UIImage(named: "placeholder10")!, postsCount: 234, commentsCount: 3241, likesCount: 12331)
        let user11 = User(name: "Andreas", surname: "Larkins", avatar: UIImage(named: "placeholder11")!, postsCount: 31, commentsCount: 43, likesCount: 22)
        let user12 = User(name: "Bob", surname: "Parkinson", avatar: UIImage(named: "placeholder12")!, postsCount: 131, commentsCount: 22, likesCount: 36)
        let user13 = User(name: "Nikolas", surname: "Peterson", avatar: UIImage(named: "placeholder13")!, postsCount: 234, commentsCount: 24, likesCount: 2344)
        let user14 = User(name: "Arnold", surname: "Watson", avatar: UIImage(named: "placeholder14")!, postsCount: 2, commentsCount: 232, likesCount: 123)
        let user15 = User(name: "Jimy", surname: "Thorndike", avatar: UIImage(named: "placeholder15")!, postsCount: 4, commentsCount: 4, likesCount: 23)
        let user16 = User(name: "Robin", surname: "Young", avatar: UIImage(named: "placeholder16")!, postsCount: 87, commentsCount: 562, likesCount: 13)
        let user17 = User(name: "Margaret", surname: "Osborne", avatar: UIImage(named: "placeholder17")!, postsCount: 534, commentsCount: 512, likesCount: 888)
        let user18 = User(name: "Viktor", surname: "Leapman", avatar: UIImage(named: "placeholder18")!, postsCount: 2, commentsCount: 34, likesCount: 99)
        let user19 = User(name: "Cristiano", surname: "Marlow", avatar: UIImage(named: "placeholder19")!, postsCount: 34, commentsCount: 133, likesCount: 3445)
        let user20 = User(name: "Luiz", surname: "Philips", avatar: UIImage(named: "placeholder20")!, postsCount: 34, commentsCount: 24, likesCount: 345)
        
        let fakeUsers = [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10, user11, user12, user13, user14, user15, user16, user17, user18, user19, user20] */
        
        
      
        
        let user = "twp_TEbBXGCnvl2HfvXWfkLUlzx92e3T"
        let password = "yatyatyat27"
        
        let credential = URLCredential(user: user, password: password, persistence: .forSession)
        
        Alamofire.request("https://yat.teamwork.com/projects.json/\(user)/\(password)")
            .authenticate(usingCredential: credential)
            .responseJSON { response in
                //debugPrint(response)
                
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
        
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while self.projects.isEmpty

        
        return self.projects
    }
    
    func GetDeadlineFromDateString(DateStr: String)-> Int
    {
     
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        
        let dateObj = dateFormatter.date(from: DateStr)
        
        dateFormatter.dateFormat = "MM-dd-yyyy"
        print("Dateobj: \(dateFormatter.string(from: dateObj!))")
        
        
        let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: dateObj!)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        print(components)
        
        let deadlineDays = components .hashValue
        
        print(deadlineDays)
        
        return components.day!
    }
        
    
    }
    
