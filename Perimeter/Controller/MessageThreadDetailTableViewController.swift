//
//  MessageDetailTableViewController.swift
//  PerimeterDemo
//
//  Created by Davone Barrett on 10/25/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MessageThreadDetailViewController: UITableViewController {
    
    let chatRoom: ChatRoom
    var users = [UserProfile]()
    
    lazy var roomImageCell: UITableViewCell = {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        let imageView = UIImageView(frame: cell.frame)
        imageView.contentMode = .scaleToFill
        cell.contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
                
        if let imageUrl = URL(string: chatRoom.chatRoomImageUrl!) {
            imageView.kf.setImage(with: imageUrl)
        }
        
        
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = chatRoom.location
        registerCell()
        getAllUsersInChatRoom()
    }
    
    init(chatRoom: ChatRoom) {
        self.chatRoom = chatRoom
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use chatroom initializer")
    }
    
    private func getAllUsersInChatRoom() {
        
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "ProfileDetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "userCell")
    }
}

extension MessageThreadDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return users.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return roomImageCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! ProfileDetailTableViewCell
            let user = users[indexPath.row]
            cell.user = user
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140.0
        } else {
            return 44.0
        }
    }
}
