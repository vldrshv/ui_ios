//
//  AvatarView.swift
//  iosui
//
//  Created by vlad on 09.02.2021.
//

import UIKit

class AvatarView: BaseView {
    
    private let nibName = "UIAvatarView"

    @IBOutlet private weak var containerView: UIView! {
        didSet {
            super.loadSubview(container: containerView)
        }
    }
    @IBOutlet private weak var avatarImage: UIImageView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    private var constraintsSize: CGFloat = 0 {
        didSet {
            widthConstraint.constant = constraintsSize
            widthConstraint.isActive = true
            heightConstraint.constant = constraintsSize
            heightConstraint.isActive = true
        }
    }
    
    var isRounded: Bool = false {
        didSet {
            makeRounded()
        }
    }
    
    var shadowRadius: CGFloat = 0 {
        didSet {
            containerView.layer.shadowRadius = shadowRadius
        }
    }
    
    var shadowOpacity: Float = 0 {
        didSet {
            containerView.layer.shadowOpacity = shadowOpacity
        }
    }
    
    var shadowColor: UIColor? = nil {
        didSet {
            containerView.layer.shadowColor = shadowColor?.cgColor
        }
    }
    
    func setSize(_ size: CGFloat) {
        self.constraintsSize = size
    }
    
    func setImage(path: String) {
        if path == "" { return }
        self.avatarImage.image = UIImage(named: path)
        
        containerView.setNeedsDisplay()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.loadView(nibName: nibName)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        super.loadView(nibName: nibName)
    }
    
    override func loadView(nibName: String) {
        super.loadView(nibName: nibName)
//        addGestureRecognizer(tapGestureRecognizer)
    }
    
    func makeRounded() {
        print(self.containerView.frame)
        self.containerView.layer.cornerRadius = constraintsSize / 2
        self.avatarImage.layer.cornerRadius = constraintsSize / 2
    }
    
    func addShadow() {
        containerView.clipsToBounds = false
        
        let layer = containerView.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
    }
}
