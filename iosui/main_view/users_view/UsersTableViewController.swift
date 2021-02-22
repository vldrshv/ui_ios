//
//  PhotosTableViewController.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import UIKit

class UsersTableViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var usersTable: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var searchView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usersTable.alwaysBounceVertical = false
        usersTable.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        usersTable.register(UINib(nibName: "UILabledTableHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "LabledTableHeader")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navController = self.navigationController else {
            return
        }
        
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: false, navigationBarHidden: true)
        
        containerView.safeAreaInsetsDidChange()
        
        initSearch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initSearchSize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("action")
        
        guard let vc = segue.destination as? SingleFriendViewController else { return }
        guard let indexPath = usersTable.indexPathForSelectedRow else { return }
        
        print("row selected = \(indexPath)")
        let user = UsersProvider.getAtSection(index: indexPath)
        vc.userPhotoPath = user.getAvatarPath()
        vc.userName = user.getName()
        
        
    }
}
    // MARK: - Table view data source
    
extension UsersTableViewController : UITableViewDataSource {

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
        cell.makeRounded()
        cell.addShadow()

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "LabledTableHeader") as! LabledTableHeader
        
        header.setText(text: UsersProvider.getSectionNameAt(section: section))
        header.setTintColor(color: tableView.backgroundColor, alfa: 0.5)
        header.setTextColor(color: UIColor.lightGray)
        
        return header
    }
    
}

extension UsersTableViewController : UITableViewDelegate {
    // MARK: - On profile clicked
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showFriendPhotos", sender: self)
        usersTable.deselectRow(at: indexPath, animated: true)
    }
}


extension UsersTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        print(searchText)
        
        UsersProvider.makeSearch(withText: searchText)
        usersTable.reloadData()
    }
    
    private func initSearch() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchView.addSubview(searchController.searchBar)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    private func initSearchSize() {
        let insets = containerView.safeAreaInsets
        
        let x = insets.left
        let y = insets.top
        let w = searchController.searchBar.frame.width
        let h = searchController.searchBar.frame.height
        
        searchView.frame = CGRect(x: x, y: y, width: w, height: h)
    }
}
