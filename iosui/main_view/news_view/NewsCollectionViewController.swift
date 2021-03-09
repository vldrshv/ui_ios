//
//  NewvsCollectionViewController.swift
//  iosui
//
//  Created by vlad on 17.02.2021.
//

import UIKit

class NewsCollectionViewController: UIViewController {

    let transitionDelegate = TransitionDelegate()
    
    private var expandedCell: UICollectionViewCell?
    private var hiddenCells: [ExpandableCell] = []
    private var isStatusBarHidden = false

    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navController = self.navigationController else {
            return
        }
        
        UINavigationUtils.manageNavigationVisibility(navController: navController, appBarHidden: false, navigationBarHidden: true)
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

        
        let title = NewsProvider.getTitleAt(index: indexPath)
        let text = NewsProvider.getTextAt(index: indexPath)
        let imagePath = NewsProvider.getImagePathAt(index: indexPath)
        let isLiked = NewsProvider.getIsLiked(index: indexPath)
        let likesCount = NewsProvider.getLikesCount(index: indexPath)
        cell.setWidth(newsCollection.bounds.width)
        cell.setNews(title: title, text: text, imagePath: imagePath)
        cell.setLikes(isLiked: isLiked, likesCount: likesCount)
        
        return cell
    }
    
}

extension NewsCollectionViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: self.newsCollection.frame.width, height: 40)//width: self.newsCollection.frame.width, height: 50)
        print("set size to \(size)")
        
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.contentOffset.y < 0 ||
                collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.frame.height {
            return
        }
        
        let dampingRatio: CGFloat = 0.8
            let initialVelocity = CGVector.zero
            let springParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
            let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: springParameters)
            
            
            self.view.isUserInteractionEnabled = false
            
        if let selectedCell = expandedCell as? ExpandableCell {
            isStatusBarHidden = false
            
            animator.addAnimations {
                selectedCell.collapse()
                
                for cell in self.hiddenCells {
                    cell.show()
                }
            }
            
            animator.addCompletion { _ in
                collectionView.isScrollEnabled = true
                
                self.expandedCell = nil
                self.hiddenCells.removeAll()
            }
        } else {
            isStatusBarHidden = true
            
            collectionView.isScrollEnabled = false
            
            let selectedCell = collectionView.cellForItem(at: indexPath)! as! ExpandableCell
            let frameOfSelectedCell = selectedCell.frame
            
            expandedCell = selectedCell
            hiddenCells = collectionView.visibleCells.map { $0 as! ExpandableCell }.filter { $0 != selectedCell }
            
            animator.addAnimations {
                selectedCell.expand(in: collectionView)
                
                for cell in self.hiddenCells {
                    cell.hide(in: collectionView, frameOfSelectedCell: frameOfSelectedCell)
                }
            }
        }
        animator.addAnimations {
                self.setNeedsStatusBarAppearanceUpdate()
            }

            animator.addCompletion { _ in
                self.view.isUserInteractionEnabled = true
            }
            
            animator.startAnimation()
        
//        let sb = UIStoryboard(name: "BottomTabs", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "SingleNewsViewController") as! SingleNewsViewController
//
//        self.present(vc, animated: true, completion: nil)
//        vc.imagePath = NewsProvider.getImagePathAt(index: indexPath)
//        vc.newsTitleText = NewsProvider.getTitleAt(index: indexPath)
//        vc.newsBodyText = NewsProvider.getTextAt(index: indexPath)
//
//        print(vc.imagePath)
        
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
