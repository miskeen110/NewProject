//
//  ProjectViewController.swift
//  TeamWorkProject
//
//  Created by Miskeen Jatoi on 8/20/17.
//  Copyright © 2017 myorg. All rights reserved.
//
import UIKit

class ProjectDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var projects = UserDataProvider().generateDataFromAPI()
    var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*For Example Description has lot of text, for fluid cell i need to add this UITableViewAutomaticDimension*/
        tableView.rowHeight = UITableViewAutomaticDimension
        /*line separator between cells removed*/
        self.tableView.separatorStyle = .none
        // Do any additional setup after loading the view, typically from a nib.
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        /*Getting data and selection index and view in the table with the help of sections */
        
       let selectedIndexString = (UserDefaults.standard.string(forKey: "selectedIndex"))
       let selectedIndex: Int = Int(selectedIndexString!)!
        
       let startDate = self.GetDateFormat(DateStr: projects[selectedIndex].startDate,completeDateFomat: false)
       let endDate = self.GetDateFormat(DateStr: projects[selectedIndex].deadline,completeDateFomat: false)
       let createdOn = self.GetDateFormat(DateStr: projects[selectedIndex].createdOn,completeDateFomat: true)
       let lastChangedOn = self.GetDateFormat(DateStr: projects[selectedIndex].lastChangedOn,completeDateFomat: true)
        sections = [
            Section(heading: "  Project Overview",
                    details: ["   Project Id           :    "+projects[selectedIndex].projectId,
                              "   Project Name    :    "+projects[selectedIndex].name,
                              "   Start Date           :    "+startDate,
                              "   End Date             :    "+endDate,
                              "   Created On          :    "+createdOn,
                              "   Last Changed On :    "+lastChangedOn],
                    expanded: true),
            Section(heading: "  Project Description",
                    details: [projects[selectedIndex].description],
                    expanded: true),
            Section(heading: "  Company Details",
                    details: ["   Company Id      :    "+projects[selectedIndex].companyId,
                              "   Company Name    :    "+projects[selectedIndex].companyName],
                    expanded: false)
        ]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].details.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return  UITableViewAutomaticDimension
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].heading, section: section, delegate: self)

        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = sections[indexPath.section].details[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].details.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    /*This function handles two types of date format, so i created a flag which handles the both type of Date Formats*/
    func GetDateFormat(DateStr: String, completeDateFomat: Bool)-> String
    {
        if completeDateFomat == false{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            dateFormatter.locale = Locale.init(identifier: "en_GB")
            let dateObj = dateFormatter.date(from: DateStr)
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateString = dateFormatter.string(from: dateObj!)
            
            return dateString
        
        
        }else{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.locale = Locale.init(identifier: "en_GB")
            let dateObj = dateFormatter.date(from: DateStr)
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            let dateString = dateFormatter.string(from: dateObj!)
            
            return dateString
            
        
        }
    }

}
