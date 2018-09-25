//
//  MessageChatTableViewCell.swift
//  Perimeter
//
//  Created by Ashley on 9/20/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import UIKit

class MessageChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageImageView: UIImageView?
    
    @IBOutlet weak var messageTitle: UILabel!
    
    
    
   
    @IBOutlet weak var messageTime: UILabel!
    
    
    
    func getCurrentDateandTime(){
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        let str = formatter.string(from: Date())
        messageTime.text = str
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
