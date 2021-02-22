//
//  SingleFriendColectionHeaderCell.swift
//  iosui
//
//  Created by vlad on 22.02.2021.
//

import UIKit

class SingleFriendColectionHeaderCell: UICollectionReusableView {

    @IBOutlet private weak var avatarView: AvatarView!
    @IBOutlet private weak var nameView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUser(userName: String, photoPath: String) {
        avatarView.setImage(path: photoPath)
        avatarView.setSize(50)
        avatarView.makeRounded()
        avatarView.addShadow()
        
        nameView.text = userName
    }
    
}
