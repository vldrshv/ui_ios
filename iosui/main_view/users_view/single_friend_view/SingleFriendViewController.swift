//
//  SingleFriendViewController.swift
//  iosui
//
//  Created by vlad on 08.02.2021.
//

import UIKit

class SingleFriendViewController: UIViewController {

    var userPhotoPath: String = ""
    var userName: String = ""
    
    private let cell_reuse_id = "PhotoCollectionViewCell"
    private let header_cell_reusable_id = "SingleFriendColectionHeaderCell"
    
    @IBOutlet private weak var userPhotosCollection: UICollectionView!
    private var cellSize: CGSize = .zero
    
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
        
        userPhotosCollection.register(
            UINib(nibName: "PhotoCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: cell_reuse_id
        )
        
        guard let navController = self.navigationController else { return }
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: true, navigationBarHidden: false)
    
        
        updateCollectionViewStyle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: presentationStyle.buttonImage, style: .plain, target: self, action: #selector(changeContentLayout))
    }
}

extension SingleFriendViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = getReusableCellFor(indexPath: indexPath) else {
            fatalError("cannot convert to 'PhotoCollectionViewCell'")
        }
        
        cell.setPhoto(path: "adidas")
        cell.setWidth(width: cellSize.width)
        cell.setHeight(height: cellSize.height)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SingleFriendColectionHeaderCell",
            for: indexPath
        ) as? SingleFriendColectionHeaderCell else { return UICollectionReusableView() }
        
        header.setUser(userName: userName, photoPath: userPhotoPath)
        
        return header
    }
    
}

// MARK: -- Collection items sizes
extension SingleFriendViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 82)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = presentationStyle.columns
        cellSize = CGSize(width: collectionView.bounds.width / columns - 1, height: collectionView.bounds.width / columns - 1)
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
        print("select")
        guard let cell = getCellFor(indexPath: indexPath) else {
            print("return")
            return
        }
        
        cell.onTap(afterTapAnimation: { collectionView.deselectItem(at: indexPath, animated: true) })

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselect")
    }
    
}

// MARK: -- Collection presentation
extension SingleFriendViewController {
    enum CollectionPresentation: String, CaseIterable {
        case column2, column3
        
        var buttonImage: UIImage {
            switch self {
            case .column2:
                return image(file: "grid_2x2")
            case .column3:
                return image(file: "grid_3x3")
            }
        }
        
        var columns: CGFloat {
            switch self {
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
        
        userPhotosCollection.reloadData()
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
}
