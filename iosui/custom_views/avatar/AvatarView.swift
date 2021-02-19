//
//  AvatarView.swift
//  iosui
//
//  Created by vlad on 09.02.2021.
//

import UIKit

@IBDesignable
class AvatarView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBInspectable var source: UIImage? = nil {
        didSet {
            self.avatarImage.image = source
        }
    }
    
    @IBInspectable var isRounded: Bool = false {
        didSet {
            makeRounded()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            containerView.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            containerView.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowColor: UIColor? = nil {
        didSet {
            containerView.layer.shadowColor = shadowColor?.cgColor
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadView()
    }
    
    private func loadView() {
            // first: load the view hierarchy to get proper outlets
        let nib = UINib(nibName: "UIAvatarView", bundle: .main)
        nib.instantiate(withOwner: self, options: nil)

        // next: append the container to our view
        self.addSubview(self.containerView)
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func makeRounded() {
        let w = self.frame.width
        let h = self.frame.height
        
        let size = max(w, h)
        
        containerView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        containerView.bounds = containerView.frame
        
        containerView.layer.cornerRadius = size / 2
//        containerView.layer.shadowColor = UIColor.black.cgColor
//        containerView.layer.shadowOffset = .zero
//        containerView.layer.shadowRadius = 15.0
//        containerView.layer.shadowOpacity = 0.5
        
        avatarImage.layer.cornerRadius = size / 2
        avatarImage.clipsToBounds = true
    
    }

    // MARK: -- Actions

    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
            let recognizer = UITapGestureRecognizer(target: self,
                                                    action: #selector(onTap))
            recognizer.numberOfTapsRequired = 1    // Количество нажатий, необходимое для распознавания
            recognizer.numberOfTouchesRequired = 1 // Количество пальцев, которые должны коснуться экрана для распознавания
            return recognizer
        }()


    @objc func onTap() {
        AnimationUtil.bouncing(unit: AnimationUnit(item: self, duration: 0.5, nextItem: nil, animType: .bounce))
    }
}
