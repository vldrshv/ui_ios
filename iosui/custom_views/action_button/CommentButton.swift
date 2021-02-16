//
//  CommentButton.swift
//  iosui
//
//  Created by vlad on 16.02.2021.
//

import UIKit

class CommentButton : ActionButton, UserInteractionListener {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setInteractionListener(listener: self)
        
        initImage()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setInteractionListener(listener: self)
        
        initImage()
        initText()
    }
    
    private func initImage() {
        if #available(iOS 13.0, *) {
            imageSource = UIImage(systemName: "square.and.pencil")
        } else {
            // Fallback on earlier versions
        }
    }
    
    func onTapRegistered() {
        AnimationUtil.scale(v: self.actionImage, scaleTo: 0.9)
    }
    
    private func initText() {
        actionLabelText = "7623"
    }
    
}
