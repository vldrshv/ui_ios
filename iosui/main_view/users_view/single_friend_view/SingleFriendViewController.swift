//
//  SingleFriendViewController.swift
//  iosui
//
//  Created by vlad on 08.02.2021.
//

import UIKit

class SingleFriendViewController: UIViewController {

    @IBOutlet var rootView: UIView!
    @IBOutlet weak var avatarImage: AvatarView!
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var loaderView: LoaderView!
    
    @IBOutlet weak var loaderViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var loaderViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.avatarImage.source = UIImage(named: "blue_rectangle")
        self.avatarImage.isRounded = true
        self.avatarImage.shadowColor = ColorUtils.black
        self.avatarImage.shadowRadius = 15.0
        self.avatarImage.shadowOpacity = 0.5
        // Do any additional setup after loading the view.
        
        likeButton.setLikes(isLiked: false, likes: 0)
//        loaderViewWidthConstraint.constant = 3 * 50
//        loaderViewHeightConstant.constant = 50
        viewDidLayoutSubviews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loaderView.setLoaderItemsCount(count: 1, shapes: [.round])
        loaderView.animate(withType: .pulse)
    }
    
    

}
