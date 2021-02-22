//
//  FadeCollectionViewLayout.swift
//  iosui
//
//  Created by vlad on 22.02.2021.
//

import UIKit

class FadeCollectionViewLayout : UICollectionViewFlowLayout {
    private let scaleRate: CGFloat = 0.2
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)?.flatMap { $0.copy() as? UICollectionViewLayoutAttributes }.flatMap(addFadeToAttributes)
    }
        
    // We need to return true here so that everytime we scroll the collection view, the attributes are updated.
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
        
    private func addFadeToAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        if self.scrollDirection == .vertical {
            return attributes
        }
            
        let width = collectionView.frame.width
        let centerX = width / 2
        let offset = collectionView.contentOffset.x
        let itemX = attributes.center.x - offset
        let position = (itemX - centerX) / width
        let contentView = collectionView.cellForItem(at: attributes.indexPath)?.contentView
            
        if abs(position) >= 1 {
            contentView?.alpha = 0
        } else {
            let alpha = 1 - abs(position)
            contentView?.alpha = alpha
        }
        
        if position <= 0 && position > -1 {
            let scaleFactor = scaleRate * CGFloat(position) + 1.0
            print(scaleFactor)
            if scaleFactor < 0.9 {
                attributes.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } else {
                attributes.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            }
        } else {
            attributes.transform = .identity
        }
            
        return attributes
    }
}
