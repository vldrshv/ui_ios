//
//  SingleFriendViewController.swift
//  iosui
//
//  Created by vlad on 08.02.2021.
//

import UIKit

class SingleFriendViewController: UIViewController {

    var userPhotoPath: String = ""
    
    @IBOutlet private weak var userPhotosCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

}

extension SingleFriendViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension SingleFriendViewController : UICollectionViewDelegateFlowLayout {
    
}
