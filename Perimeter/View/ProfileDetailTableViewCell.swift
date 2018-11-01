//
//  ProfileDetailTableViewCell.swift
//  PerimeterDemo
//
//  Created by Davone Barrett on 10/25/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usersNameLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var user: UserProfile? {
        didSet {
            usersNameLabel.text = "\(user?.firstName ?? "") \(user?.lastName ?? "")"
            displayNameLabel.text = user?.displayName
            if let imageUrl = URL(string: user!.profileImageUrl!) {
                profileImageView.kf.setImage(with: imageUrl)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
