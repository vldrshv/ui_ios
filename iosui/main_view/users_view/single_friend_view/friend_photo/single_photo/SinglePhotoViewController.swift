//
//  SinglePhotoCollectionViewController.swift
//  iosui
//
//  Created by vlad on 22.02.2021.
//

import UIKit

class SinglePhotoViewController: UIViewController {
    
    private let cell_reuse_id = "PhotoCollectionViewCell"
    @IBOutlet var photoCollectionView: UICollectionView!
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private var cellSize: CGSize = .zero
    
    var user: IUser = VkUser.empty()
    var index: IndexPath = IndexPath()
    private let provider = PhotoProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        photoCollectionView.register(
            UINib(nibName: "PhotoCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: cell_reuse_id
        )
        
        guard let navController = self.navigationController else { return }
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: true, navigationBarHidden: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        provider.getData(userId: user.getId()) {
            self.photoCollectionView.reloadData()
            self.photoCollectionView.scrollToItem(at: self.index, at: .centeredHorizontally, animated: false)
        }
    }
}

extension SinglePhotoViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return provider.getPhotoCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_reuse_id, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("cannot convert to 'PhotoCollectionViewCell'")
        }
    
        let photoPath = provider.getHD(index: indexPath)
        
        cell.setPhoto(path: photoPath)
        cell.setWidth(width: cellSize.width)
        cell.setHeight(height: cellSize.height)
        cell.setPhotoFitMode(mode: .scaleAspectFit)
    
        return cell
    }

}

extension SinglePhotoViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        return cellSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
