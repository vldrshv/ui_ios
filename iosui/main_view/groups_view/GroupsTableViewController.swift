//
//  GroupsTableTableViewController.swift
//  iosui
//
//  Created by vlad on 05.02.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController, DataChangeListener {

    @IBOutlet var tableGroups: UITableView!
    @IBOutlet weak var searchView: UIStackView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let api = VkApi()
    private var timer: Timer?
    
    private var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableGroups.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupsCell")
        
        initSearch()
        
        api.getGroupsFor(userId: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manageAppBar()
    }
    
    private func manageAppBar() {
        guard let navController = self.navigationController else {
            return
        }
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: false, navigationBarHidden: true)
        
    }
    
    // MARK: - Table view data source
    
    func onDataChanged() {
        tableGroups.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupsProvider.subscribedCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as? GroupsTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        manageCell(cell, group: GroupsProvider.getGroupFromSubscribed(at: indexPath))

        return cell
    }
        
    private func manageCell(_ cell: GroupsTableViewCell, group: IGroup) {
        cell.setGroup(group: group) {
            group.doAction()
            self.tableView.reloadData()
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableGroups.deselectRow(at: indexPath, animated: true)
    }
}

extension GroupsTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        timer?.invalidate()  // Cancel any previous timer

        if (text.count >= 3) {
            searchText = text
            // …schedule a timer for 0.5 seconds
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(performSearch), userInfo: nil, repeats: false)
        }
    }
    
    private func initSearch() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchView.addSubview(searchController.searchBar)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    @objc func performSearch() {
        print(searchText)
        if (searchText.count > 0) {
            api.searchGroups(text: searchText)
        }
    }
}

protocol DataChangeListener {
    func onDataChanged()
}
