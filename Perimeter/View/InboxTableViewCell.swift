//
//  InboxTableViewCell.swift
//  Perimeter
//
//  Created by Ashley on 9/25/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import UIKit
import Kingfisher

class InboxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chatRoomImage: UIImageView!
   
    @IBOutlet weak var chatRoomName: UILabel!
    
    @IBOutlet weak var chatMessageTime: UILabel!
    
    @IBOutlet weak var chatFinalMessage: UILabel!
    
    var indexpath :IndexPath!
    
    let tapGesture = UITapGestureRecognizer()
    
    var dateFormatter : DateFormatter = {
        let date = DateFormatter()
        date.dateFormat = "h:mm a"
        return date
    }()
    
    var chatRoom: ChatRoom? {
        didSet{
            
            chatRoomName.text = chatRoom?.location
            
            
            if let imageURL = URL(string: (chatRoom?.chatRoomImageUrl)!){
                chatRoomImage.kf.setImage(with: imageURL)
                chatRoomImage.layer.cornerRadius=self.chatRoomImage.frame.size.width / 2;
                chatRoomImage.clipsToBounds = true;
                chatRoomImage.layer.borderWidth = 1.0;
                chatRoomImage.layer.borderColor = UIColor.white.cgColor
            }
          
            if let lastMessage = chatRoom?.lastMessage {
    
                chatFinalMessage.text = lastMessage.message
                chatMessageTime.text = dateFormatter.string(from: lastMessage.timestamp.dateValue())}
            else {
                chatFinalMessage.text = "No Messages"
                chatMessageTime.text = "N/A"
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        }
        
        
    
    

