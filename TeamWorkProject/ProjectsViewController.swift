//
//  ViewController.swift
//  TeamWorkProject
//
//  Created by Miskeen Jatoi on 8/20/17.
//  Copyright © 2017 myorg. All rights reserved.
//


import UIKit
import DisplaySwitcher
    /*animation variables of changing list to grid or viceversa*/
private let animationDuration: TimeInterval = 0.3
private let listLayoutStaticCellHeight: CGFloat = 80
private let gridLayoutStaticCellHeight: CGFloat = 165

class ProjectsViewController: UIViewController {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var rotationButton: SwitchLayoutButton!

    fileprivate var tap: UITapGestureRecognizer!
    /*getting values from API */
    fileprivate var projects = UserDataProvider().generateDataFromAPI()
    fileprivate var searchProjects = [Projects]()
    fileprivate var isTransitionAvailable = true
    fileprivate lazy var listLayout = DisplaySwitchLayout(staticCellHeight: listLayoutStaticCellHeight, nextLayoutStaticCellHeight: gridLayoutStaticCellHeight, layoutState: .list)
    fileprivate lazy var gridLayout = DisplaySwitchLayout(staticCellHeight: gridLayoutStaticCellHeight, nextLayoutStaticCellHeight: listLayoutStaticCellHeight, layoutState: .grid)
    fileprivate var layoutState: LayoutState = .list
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        searchProjects = projects
        rotationButton.isSelected = true
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*delete for another selection of index */
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "selectedIndex")
    }
    
    // MARK: - Private methods
    fileprivate func setupCollectionView() {
        collectionView.collectionViewLayout = listLayout
        collectionView.register(UserCollectionViewCell.cellNib, forCellWithReuseIdentifier:UserCollectionViewCell.id)
    }
    
    // MARK: - Actions
    @IBAction func buttonTapped(_ sender: AnyObject) {
        /*This is the function where layout is changed by calling DisplaySwitcher Pod*/
        if !isTransitionAvailable {
            return
        }
        let transitionManager: TransitionManager
        if layoutState == .list {
            layoutState = .grid
            transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionView!, destinationLayout: gridLayout, layoutState: layoutState)
        } else {
            layoutState = .list
            transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionView!, destinationLayout: listLayout, layoutState: layoutState)
        }
        transitionManager.startInteractiveTransition()
        rotationButton.isSelected = layoutState == .list
        rotationButton.animationDuration = animationDuration
    }
    
    @IBAction func tapRecognized() {
        view.endEditing(true)
    }
    
}

extension ProjectsViewController {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchProjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.id, for: indexPath) as! UserCollectionViewCell
        if layoutState == .grid {
            cell.setupGridLayoutConstraints(1, cellWidth: cell.frame.width)
        } else {
            cell.setupListLayoutConstraints(1, cellWidth: cell.frame.width)
        }
        cell.bind(searchProjects[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        let customTransitionLayout = TransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
        return customTransitionLayout
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isTransitionAvailable = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isTransitionAvailable = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}

extension ProjectsViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchProjects = projects
        } else {
            searchProjects = searchProjects.filter { return $0.name.contains(searchText) }
        }
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView,didSelectItemAtIndexPath indexPath: IndexPath) {
        /*********************There are another ways as well to pass data between
         view controller but i used the use the memory one.
         Another is define variable into destinationViewController and before pushing set the 
         value of view controller, which is the easy one.*************/
        
        UserDefaults.standard.set(String(indexPath.row), forKey: "selectedIndex")
        let projectInfoVC = storyboard?.instantiateViewController(withIdentifier: "ProjectInfo")
        self.navigationController?.pushViewController(projectInfoVC!, animated: true);
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tap)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tap)
    }
    
    func handleTap() {
        view.endEditing(true)
    }
}

