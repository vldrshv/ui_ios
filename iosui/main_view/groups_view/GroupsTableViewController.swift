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
    @IBOutlet weak var clearSearchButton: UIButton!
    @IBOutlet weak var searchViewWidth: NSLayoutConstraint!
    
    @IBAction func searchGroups(_ sender: Any) {
        setSearchWidth(1)
//        let sb = UIStoryboard(name: "BottomTabs", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "AddGroupsController") as! GroupItemTableViewController
//
//        vc.setDataChangeListener(listener: self)
//
//        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableGroups.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupsCell")
        
        let api = VkApi()
        api.getGroupsFor(userId: nil)
        setSearchWidth()
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
    
    private func setSearchWidth(_ width: CGFloat? = nil) {
        UIView.animate(
            withDuration: 0.1,
                animations: {
                    if width == nil {
                        self.searchView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
                    } else {
                        self.searchView.transform = CGAffineTransform.identity
                    }
                },
                completion: { _ in
                    print()
//                    doOnComplete?()
//                    UIView.animate(withDuration: 0.6) {
//                        v.transform = CGAffineTransform.identity
//                    }
                })
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
