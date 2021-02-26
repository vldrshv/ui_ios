//
//  SingleFriendViewController.swift
//  iosui
//
//  Created by vlad on 08.02.2021.
//

import UIKit

class SingleFriendViewController: UIViewController {
    private let transitionDelegate = TransitionDelegate()
    

    var userName: String = "" {
        didSet {
            user = UsersProvider.getUserBy(name: userName)
        }
    }
    private var user: IUser = VkUser.empty()
    
    private let cell_reuse_id = "PhotoCollectionViewCell"
    private let header_cell_reusable_id = "SingleFriendColectionHeaderCell"
    
    @IBOutlet private weak var userPhotosCollection: UICollectionView!
    @IBOutlet weak var usersPhotoCollectionFlow: UICollectionViewFlowLayout!
    
    private var cellSize: CGSize = .zero
    private var scrollOffset = 0
    
    private var presentationStyle = CollectionPresentation.column2 {
        didSet {
            updateCollectionViewStyle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userPhotosCollection.register(
            UINib(nibName: "SingleFriendColectionHeaderCell", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: header_cell_reusable_id)
        usersPhotoCollectionFlow.sectionHeadersPinToVisibleBounds = true
        
        userPhotosCollection.register(
            UINib(nibName: "PhotoCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: cell_reuse_id
        )
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("open user photo")
//
//        guard let vc = segue.destination as? SinglePhotoViewController else { return }
//        guard let indexPath = getIndexOfSelected() else { return }
//
//        vc.user = user
//        vc.index = indexPath
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navController = self.navigationController else { return }
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: true, navigationBarHidden: false)
        
        let photoCnt = user.getPhotoCount()
        if photoCnt < 2 {
            presentationStyle = .column1
            navigationItem.rightBarButtonItem = nil
            return
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: presentationStyle.buttonImage, style: .plain, target: self, action: #selector(changeContentLayout))
    }
}

extension SingleFriendViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.getPhotoCount()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = getReusableCellFor(indexPath: indexPath) else {
            fatalError("cannot convert to 'PhotoCollectionViewCell'")
        }
        
        let photoPath = user.getPhotoPathAt(index: indexPath.item)
        
        cell.setPhoto(path: photoPath)
        cell.setWidth(width: cellSize.width)
        cell.setHeight(height: cellSize.height)
        
        print("cell")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SingleFriendColectionHeaderCell",
            for: indexPath
        ) as? SingleFriendColectionHeaderCell else { return UICollectionReusableView() }
                
        header.setUser(userName: userName, photoPath: user.getAvatarPath())
        
        return header
    }
    
}

// MARK: -- Collection items sizes
extension SingleFriendViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 82)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = presentationStyle.columns
        cellSize = CGSize(
            width: collectionView.bounds.width / columns - 1,
            height: collectionView.bounds.width / columns - 1
        )
        return cellSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
// MARK: --Collection View Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cell = getCellFor(indexPath: indexPath) else { return }
        
//        self.performSegue(withIdentifier: "openImageFullscreen", sender: self)
        print("open user photo")
        
        let sb = UIStoryboard(name: "BottomTabs", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SinglePhotoViewController") as! SinglePhotoViewController
        
        guard let indexPath = getIndexOfSelected() else { return }
        
        vc.user = user
        vc.index = indexPath
        
        vc.transitioningDelegate = transitionDelegate
        self.present(vc, animated: true, completion: nil)
        
        collectionView.deselectItem(at: indexPath, animated: false)
    }

}

// MARK: -- Collection presentation
extension SingleFriendViewController {
    enum CollectionPresentation: String, CaseIterable {
        case column1, column2, column3
        
        var buttonImage: UIImage {
            switch self {
            case .column1:
                return image(file: "grid_1x1")
            case .column2:
                return image(file: "grid_2x2")
            case .column3:
                return image(file: "grid_3x3")
            }
        }
        
        var columns: CGFloat {
            switch self {
            case .column1:
                return 1.0
            case .column2:
                return 2.0
            case .column3:
                return 3.0
            }
        }
        
        func image(file: String)  -> UIImage {
            guard let img = UIImage(named: file) else { return UIImage() }
            
            return img
        }
    }
    
    func updateCollectionViewStyle() {
        navigationItem.rightBarButtonItem?.image = presentationStyle.buttonImage
        
//        userPhotosCollection.reloadData()
        
        userPhotosCollection.performBatchUpdates(
            nil,
            completion: {_ in self.userPhotosCollection.reloadData() }
        )
    }
    
    @objc private func changeContentLayout() {
        let allCases = CollectionPresentation.allCases
        guard let index = allCases.firstIndex(of: presentationStyle) else { return }
        
        let nextIndex = (index + 1) % allCases.count
        presentationStyle = allCases[nextIndex]
    }
}


// MARK: -- Utils
extension SingleFriendViewController {
    func getReusableCellFor(indexPath: IndexPath) -> PhotoCollectionViewCell? {
        return userPhotosCollection.dequeueReusableCell(withReuseIdentifier: cell_reuse_id, for: indexPath) as? PhotoCollectionViewCell
    }
    
    func getCellFor(indexPath: IndexPath) -> PhotoCollectionViewCell? {
        return userPhotosCollection.cellForItem(at: indexPath) as? PhotoCollectionViewCell
    }
    
    func getSelectedCellRect(at: IndexPath) -> CGRect {
        guard let cell = getCellFor(indexPath: at) else { return CGRect() }
        
        return cell.frame
    }
    
    func getIndexOfSelected() -> IndexPath? {
        guard let indexes = userPhotosCollection.indexPathsForSelectedItems else { return nil }
        
        if indexes.count < 1 { return nil }
        
        return indexes[0]
    }
}
