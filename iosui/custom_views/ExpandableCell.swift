//
//  Expandable.swift
//  iosui
//
//  Created by vlad on 09.03.2021.
//

import UIKit

class ExpandableCell : UICollectionViewCell {
    
    private var initialFrame: CGRect? = nil
    private var initialCornerRadius: CGFloat? = nil
    
    private var doOnExpand: (() -> Void)? = nil
    private var doOnCollapse: (() -> Void)? = nil
    
    func setOnExpand(doOnExpand: @escaping () -> Void) {
        self.doOnExpand = doOnExpand
    }

    func setOnCollapse(doOnCollapse: @escaping () -> Void) {
        self.doOnCollapse = doOnCollapse
    }
    
    func expand(in collectionView: UICollectionView) {
        initialFrame = self.frame
        initialCornerRadius = self.contentView.layer.cornerRadius
        
        self.contentView.layer.cornerRadius = 0
        self.frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)
        
        doOnExpand?()
        
        layoutIfNeeded()
    }

    func collapse() {
        self.contentView.layer.cornerRadius = initialCornerRadius ?? self.contentView.layer.cornerRadius
        self.frame = initialFrame ?? self.frame
        
        initialFrame = nil
        initialCornerRadius = nil

        doOnCollapse?()
        
        layoutIfNeeded()
    }
    
    func hide(in collectionView: UICollectionView, frameOfSelectedCell: CGRect) {
        initialFrame = self.frame
        
        let currentY = self.frame.origin.y
        let newY: CGFloat
        
        if currentY < frameOfSelectedCell.origin.y {
            let offset = frameOfSelectedCell.origin.y - currentY
            newY = collectionView.contentOffset.y - offset
        } else {
            let offset = currentY - frameOfSelectedCell.maxY
            newY = collectionView.contentOffset.y + collectionView.frame.height + offset
        }
        
        self.frame.origin.y = newY
        
        layoutIfNeeded()
    }

    func show() {
        self.frame = initialFrame ?? self.frame
        
        initialFrame = nil
        
        layoutIfNeeded()
    }
}
