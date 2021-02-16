//
//  LikeButton.swift
//  iosui
//
//  Created by vlad on 09.02.2021.
//

import UIKit

class LikeButton: ActionButton, UserInteractionListener {

    private var isLiked = false
    private var likes = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setInteractionListener(listener: self)
        
        initImage()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setInteractionListener(listener: self)
        
        initImage()
    }
    
    func setLikes(isLiked: Bool, likes: Int) {
        self.isLiked = isLiked
        self.likes = likes
        update()
    }
    
    func onTapRegistered() {
        AnimationUtil.scale(v: self.actionImage, scaleTo: 0.95)
        isLiked = !isLiked
        likes += isLiked ? 1 : -1
        update()
    }
    
    private func update() {
        if isLiked {
            self.actionImage.tintColor = UIColor.red
            self.actionLabel.textColor = UIColor.red
            
            guard let activeImage = imageSourceActive else { return }
            self.actionImage.image = activeImage
        } else {
            self.actionImage.tintColor = UIColor.black
            self.actionLabel.textColor = UIColor.black
            self.actionImage.image = imageSource
        }
        
        self.actionLabelText = "\(likes)"
    }
    
    private func initImage() {
        if #available(iOS 13.0, *) {
            imageSource = UIImage(systemName: "heart")
            imageSourceActive = UIImage(systemName: "heart.fill")
        } else {
            // Fallback on earlier versions
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
