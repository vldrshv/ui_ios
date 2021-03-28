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
        guard let url = URL(string: path) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.avatarImage.image = image
                    }
                }
            }
        }
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
        addGestureRecognizer(tapGestureRecognizer)
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
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
            let recognizer = UITapGestureRecognizer(target: self,
                                                    action: #selector(onTap))
            recognizer.numberOfTapsRequired = 1    // Количество нажатий, необходимое для распознавания
            recognizer.numberOfTouchesRequired = 1 // Количество пальцев, которые должны коснуться экрана для распознавания
            return recognizer
        }()
    
    @objc func onTap() {
        print("avatar")
        AnimationUtil.bouncing(unit: AnimationUnit(item: self, duration: 0.5, nextItem: nil, animType: .bounce))
    }
}
