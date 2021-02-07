//
//  PhotosTableViewController.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import UIKit

class UsersTableViewController: UITableViewController {

    @IBOutlet weak var usersTable: UITableView!
    
    private var usersProvider = UsersProvider() // presenter or smth else with logic
    private var users = [IUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        usersTable.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        users.append(contentsOf: self.usersProvider.getUsers())
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        
        let user = users[indexPath.item]
        
        cell.setUser(user: user)

        // Configure the cell...

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navContriller = self.navigationController else {
            return
        }
        
        UINavigationUtils.manageNavigationVisibility(navController: navContriller, appBarHidden: false, bottomBarHidden: true)
    }
    
}
