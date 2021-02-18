//
//  ActionButton.swift
//  iosui
//
//  Created by vlad on 09.02.2021.
//

import UIKit

class ActionButton: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var actionLabel: UILabel!
    
    @IBInspectable var imageSource: UIImage? = nil {
        didSet {
            self.actionImage.image = imageSource
            self.actionImage.tintColor = ColorUtils.black
            resizeImage()
        }
    }
    
    @IBInspectable var imageSourceActive: UIImage? = nil
    
    @IBInspectable var actionLabelText: String = "" {
        didSet {
            self.actionLabel.isHidden = actionLabelText == ""
            self.actionLabel.text = actionLabelText
        }
    }
    
    private var listener: UserInteractionListener? = nil
    
    func setInteractionListener(listener: UserInteractionListener) {
        self.listener = listener
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadView()
    }
    
    func resizeImage() {
        print("resize image")
        guard let image = imageSource else { return }

        let h = containerView.frame.height
        let w = image.size.width
        
        if h > w {
            let newWidth = w * (image.size.height / image.size.width)
            actionImage.frame.size = CGSize(width: newWidth, height: h)
        }
        else{
            let newWidth = w / (image.size.height / image.size.width)
            actionImage.frame.size = CGSize(width: newWidth, height: h)
        }
    }
    
    private func loadView() {
            // first: load the view hierarchy to get proper outlets
        let nib = UINib(nibName: "UIActionButton", bundle: .main)
        nib.instantiate(withOwner: self, options: nil)

        // next: append the container to our view
        self.addSubview(self.containerView)
        
        let w = self.frame.width
        let h = self.frame.height
        
        self.containerView.frame = CGRect(origin: self.center, size: CGSize(width: w, height: h))
        self.containerView.bounds = self.containerView.frame
        self.containerView.setNeedsLayout()
        
        addGestureRecognizer(tapGestureRecognizer)
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
        listener?.onTapRegistered()
    }
}
