//
//  NewsViewController.swift
//  iosui
//
//  Created by vlad on 16.02.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {

    @IBOutlet var newsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTable.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsPhotoCell")

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navController = self.navigationController else {
            return
        }
        
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: false, navigationBarHidden: true)
    
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsProvider.getNewsCount()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoCell", for: indexPath) as? PhotoTableViewCell else {
            fatalError("The dequeued cell is not an instance of PhotoTableViewCell.")
        }
        
        cell.setNewsText(text: NewsProvider.lables[indexPath.item])
        cell.setImagePath(path: NewsProvider.imgPath[indexPath.item])
        cell.setLikes(isLiked: NewsProvider.isLiked[indexPath.item], likes: NewsProvider.likes[indexPath.item])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
