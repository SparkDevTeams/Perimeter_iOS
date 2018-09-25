//
//  InboxTableViewCell.swift
//  Perimeter
//
//  Created by Ashley on 9/13/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import UIKit
import Firebase



class InboxTableViewCell: UITableViewCell {
    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var messagePreview: UILabel!

//    var messageDetail: MessageDetail!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
