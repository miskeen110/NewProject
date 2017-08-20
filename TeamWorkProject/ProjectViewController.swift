//
//  ProjectViewController.swift
//  TeamWorkProject
//
//  Created by Kaisa Tuononen on 8/20/17.
//  Copyright © 2017 myorg. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var projectDetails: AnyObject?
    var sections = [
        Section(genre: "🦁 Animation",
                movies: ["The Lion King", "The Incredibles"],
                expanded: false),
        Section(genre: "💥 Superhero",
                movies: ["Guardians of the Galaxy", "The Flash", "The Avengers", "The Dark Knight"],
                expanded: false),
        Section(genre: "👻 Horror",
                movies: ["The Walking Dead", "Insidious", "Conjuring"],
                expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = sections[indexPath.section].movies[indexPath.row]
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].movies.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    

    


}
