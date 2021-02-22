//
//  PhotoCollectionViewCell.swift
//  iosui
//
//  Created by vlad on 22.02.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setPhoto(path: String) {
        guard let image = UIImage(named: path) else {
            return
        }
        
        self.photoView.image = image
    }
    
    func setWidth(width: CGFloat) {
        imageWidthConstraint.isActive = true
        imageWidthConstraint.constant = width
    }
    
    func setHeight(height: CGFloat) {
        imageHeightConstraint.isActive = true
        imageHeightConstraint.constant = height
    }

    func onTap(afterTapAnimation: (() -> Void)?) {
        
        print("on tap")
        AnimationUtil.scale(v: self, scaleTo: 0.9,
                            doOnComplete: afterTapAnimation
        )
    }
}
