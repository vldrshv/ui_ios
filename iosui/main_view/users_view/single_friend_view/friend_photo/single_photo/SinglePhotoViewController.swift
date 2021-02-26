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
    @IBAction func closeView(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    private var cellSize: CGSize = .zero
    
    var user: IUser = VkUser.empty() {
        didSet {
            let cnt = user.getPhotoCount()
            for i in 0..<cnt {
                print(user.getPhotoPathAt(index: i))
            }
        }
    }
    var index: IndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoCollectionView.register(
            UINib(nibName: "PhotoCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: cell_reuse_id
        )
        
        guard let navController = self.navigationController else { return }
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: true, navigationBarHidden: true)
    }
    
    override func viewDidLayoutSubviews() {
        photoCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
    }
}

extension SinglePhotoViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.getPhotoCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_reuse_id, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("cannot convert to 'PhotoCollectionViewCell'")
        }
    
        let photoPath = user.getPhotoPathAt(index: indexPath.item)
        
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
