//
//  NewvsCollectionViewController.swift
//  iosui
//
//  Created by vlad on 17.02.2021.
//

import UIKit

class NewsCollectionViewController: UIViewController {

    @IBOutlet private weak var newsCollection: UICollectionView!
    @IBOutlet weak var newsCollectionFlow: UICollectionViewFlowLayout! {
        didSet {
            newsCollectionFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newsCollection.register(
            UINib(nibName: "UINewsCollectionCell", bundle: nil),
            forCellWithReuseIdentifier: "NewsCollectionCell"
        )
        
    }
    
}

extension NewsCollectionViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsProvider.getNewsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionCell", for: indexPath) as? NewsCollectionCell else {
            fatalError("cannot load NewsCollectionCell for index = \(indexPath)")
        }
        
        print("cell for: index = \(indexPath), cell size: \(cell.frame.size)")

        
        cell.setWidth(newsCollection.bounds.width)
        cell.setNews(
            title: NewsProvider.getTitleAt(index: indexPath),
            imagePath: NewsProvider.getImagePathAt(index: indexPath)
        )
        
        return cell
    }
    
}

extension NewsCollectionViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: self.newsCollection.frame.width, height: 40)//width: self.newsCollection.frame.width, height: 50)
        print("set size to \(size)")
        
        return size
    }
}
