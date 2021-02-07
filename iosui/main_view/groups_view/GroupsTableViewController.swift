//
//  GroupsTableTableViewController.swift
//  iosui
//
//  Created by vlad on 05.02.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    @IBOutlet var tableGroups: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableGroups.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupsCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manageAppBar()
    }
    
    private func manageAppBar() {
        guard let navController = self.navigationController else {
            return
        }
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: false, bottomBarHidden: false)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(GroupsProvider.subscribedCount())
        return GroupsProvider.subscribedCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as? GroupsTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let group = GroupsProvider.getGroup(at: indexPath)
        cell.setGroup(group: group){
            group.doAction()
            
            var title = "subscribe"
            if group.isUserSubscribed() {
                title = "unsubscribe"
            }
            
//            cell.initButtonStyle(isActive: group.isUserSubscribed(), text: title)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        
//        cell.groupLabel.text = "\(indexPath.item)"

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableGroups.deselectRow(at: indexPath, animated: true)
    }
}
