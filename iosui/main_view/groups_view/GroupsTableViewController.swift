//
//  GroupsTableTableViewController.swift
//  iosui
//
//  Created by vlad on 05.02.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController, DataChangeListener {

    @IBOutlet var tableGroups: UITableView!
    
    @IBAction func addGroups(_ sender: Any) {
        let sb = UIStoryboard(name: "BottomTabs", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddGroupsController") as! GroupItemTableViewController
        
        vc.setDataChangeListener(listener: self)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableGroups.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupsCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manageAppBar()
    }
    
    private func manageAppBar() {
        guard let navController = self.navigationController else {
            return
        }
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: false, navigationBarHidden: false)
        
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

protocol DataChangeListener {
    func onDataChanged()
}
