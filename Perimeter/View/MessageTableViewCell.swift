//
//  MessageTableViewCell.swift
//  PerimeterDemo
//
//  Created by Davone Barrett on 9/26/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageSentDateLabel: UILabel!
    @IBOutlet weak var senderDisplayNameLabel: UILabel!
    @IBOutlet weak var senderProfileImageView: UIImageView!
    
    private var dateFormmater: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        return df
    }()
    
    var message: Message? {
        didSet {
            senderDisplayNameLabel.text = message?.senderDisplayName
            messageLabel.text = message?.message
            messageSentDateLabel.text = dateFormmater.string(from: message!.timestamp.dateValue())
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
