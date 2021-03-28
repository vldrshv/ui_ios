//
//  SingleFriendViewController.swift
//  iosui
//
//  Created by vlad on 08.02.2021.
//

import UIKit

class SingleFriendViewController: UIViewController {
    private let transitionDelegate = TransitionDelegate()
    private let cell_reuse_id = "PhotoCollectionViewCell"
    private let header_cell_reusable_id = "SingleFriendColectionHeaderCell"
    
    @IBOutlet private weak var userPhotosCollection: UICollectionView!
    @IBOutlet weak var usersPhotoCollectionFlow: UICollectionViewFlowLayout!
    
    private var cellSize: CGSize = .zero
    private var scrollOffset = 0
    
    private let provider = PhotoProvider()
    var user: IUser = VkUser.empty()
    
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
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navController = self.navigationController else { return }
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: true, navigationBarHidden: false)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: presentationStyle.buttonImage, style: .plain, target: self, action: #selector(changeContentLayout))
        
        provider.getData(userId: user.getId()) {
            let photoCnt = self.provider.getPhotoCount()
            if photoCnt < 2 {
                self.presentationStyle = .column1
                self.navigationItem.rightBarButtonItem = nil
                return
            }
            self.userPhotosCollection.reloadData()
        }
    }
}

extension SingleFriendViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return provider.getPhotoCount()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = getReusableCellFor(indexPath: indexPath) else {
            fatalError("cannot convert to 'PhotoCollectionViewCell'")
        }
        
        var photoPath = ""
        switch presentationStyle {
        case .column3: photoPath = provider.getMedium(index: indexPath)
        default: photoPath = provider.getLarge(index: indexPath)
        }
        
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
                
        header.setUser(userName: user.getName(), photoPath: user.getAvatarPath())
        
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
        
        transitionDelegate.setFrame(cell)
        
        showPhotosFullScreen()
        
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    private func showPhotosFullScreen() {
        let sb = UIStoryboard(name: "BottomTabs", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SinglePhotoViewController") as! SinglePhotoViewController

        guard let indexPath = getIndexOfSelected() else { return }
//        guard let cellFrame = getCellFor(indexPath: indexPath)?.frame else { return }

        vc.user = user
        vc.index = indexPath
        
        vc.transitioningDelegate = transitionDelegate
        
        self.present(vc, animated: true, completion: nil)
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
