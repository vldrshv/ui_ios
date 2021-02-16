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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.avatarImage.source = UIImage(named: "blue_rectangle")
        self.avatarImage.isRounded = true
        self.avatarImage.shadowColor = ColorUtils.black
        self.avatarImage.shadowRadius = 15.0
        self.avatarImage.shadowOpacity = 0.5
        // Do any additional setup after loading the view.
        
        likeButton.setLikes(isLiked: false, likes: 0)

    }
    

}
