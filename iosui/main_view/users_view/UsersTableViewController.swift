//
//  PhotosTableViewController.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import UIKit

class UsersTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var usersTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        usersTable.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        usersTable.register(UINib(nibName: "UILabledTableHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "LabledTableHeader")
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return UsersProvider.getSectionsCount()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UsersProvider.getUsersInSectionCount(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        
        let user = UsersProvider.getAtSection(index: indexPath)
        
        cell.setUser(user: user)

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "LabledTableHeader") as! LabledTableHeader
        
        header.setText(text: UsersProvider.getSectionNameAt(section: section))
        header.setTintColor(color: tableView.backgroundColor, alfa: 0.5)
        header.setTextColor(color: UIColor.lightGray)
        
        return header
    }
    
    // MARK: - On profile clicked
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        usersTable.deselectRow(at: indexPath, animated: true)
        
        let sb = UIStoryboard(name: "BottomTabs", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SingleFriendViewController")
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navContriller = self.navigationController else {
            return
        }
        
        UINavigationUtils.manageNavigationVisibility(navController: navContriller, appBarHidden: false, navigationBarHidden: true)
    }
    
}
