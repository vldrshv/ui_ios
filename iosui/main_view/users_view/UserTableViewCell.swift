//
//  UserTableViewCell.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastOnlineDateLabel: UILabel!
    @IBOutlet weak var avatarContainer: AvatarView!
//    @IBOutlet weak var avatarView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUser(user: IUser) {
        self.nameLabel.text = user.getName()
        self.lastOnlineDateLabel.text = user.getLastOnlineDate()


        self.avatarContainer.setImage(path: user.getAvatarPath())
    }
    
    func makeRounded() {
        avatarContainer.setSize(self.avatarContainer.frame.width)
        avatarContainer.makeRounded()
        avatarContainer.setNeedsDisplay()
    }

    func addShadow() {
        avatarContainer.addShadow()
        avatarContainer.setNeedsDisplay()
    }
    
    func registerTap() {
        avatarContainer.onTap()
    }
}
