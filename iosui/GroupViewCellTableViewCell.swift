//
//  GroupViewCellTableViewCell.swift
//  iosui
//
//  Created by vlad on 05.02.2021.
//

import UIKit

class GroupViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setName(_ name: String) {
        groupName.text = name
    }

}
