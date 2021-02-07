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
    @IBOutlet weak var avatarView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUser(user: IUser) {
        self.nameLabel.text = user.getName()
        self.lastOnlineDateLabel.text = user.getLastOnlineDate()
        self.avatarView.image = UIImage(named: user.getAvatarPath())
    }
    
}
