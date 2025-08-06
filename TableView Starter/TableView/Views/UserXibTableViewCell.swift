//
//  UserXibTableViewCell.swift
//  TableView
//
//  Created by mac on 6/7/25.
//

import UIKit

class UserXibTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    static let idntifier = "UserXibTableViewCell"
    
    func configure(user: UserModel) {
        nameLabel.text = user.name
        avatarImageView.image = user.avatar
        bioLabel.text = user.bio
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
}
