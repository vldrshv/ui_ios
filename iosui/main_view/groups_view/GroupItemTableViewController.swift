//
//  GroupItemTableViewController.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import UIKit

class GroupItemTableViewController: UITableViewController {

    @IBOutlet var tableGroups: UITableView!
    
    private var dataListener: DataChangeListener? = nil
    
    deinit {
        dataListener = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableGroups.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupsCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navController = self.navigationController else {
            return
        }
        
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: true, bottomBarHidden: true)
    }
    
    func setDataChangeListener(listener: DataChangeListener) {
        dataListener = listener
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GroupsProvider.unsubscribedCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as? GroupsTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        manageCell(cell, group: GroupsProvider.getGroupFromUnsubscribed(at: indexPath))

        return cell
    }
    
    private func manageCell(_ cell: GroupsTableViewCell, group: IGroup) {
        cell.setGroup(group: group) {
            group.doAction()
            let text = group.isUserSubscribed() ? "unsubscribe" : "subscribe"
            cell.initButtonStyle(isActive: group.isUserSubscribed(), text: text)
//            self.tableView.reloadData()
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableGroups.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dataListener?.onDataChanged()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
