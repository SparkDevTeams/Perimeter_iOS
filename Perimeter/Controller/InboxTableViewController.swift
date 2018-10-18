//
//  InboxTableViewController.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/8/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class InboxTableViewController: UITableViewController {
    //var chatrooms = [String]()
    var chatrooms = [ChatRoom]()
    
    let cellIdentifer = "InboxCell"
    
    let firebase = FirebaseAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        title = "Chatrooms"
    }
    
    func registerCell() {
        let nib = UINib(nibName: "InboxTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifer)
    }

    private func loadChatRooms(){
        
        firebase.fetchAllChatRooms{(chatRooms, error) in
            self.chatrooms = chatRooms
            
            for chatRoom in chatRooms{
                self.firebase.fetchMessagesForChatRoom(chatRoom, completion: {(messages,messagesRef,error) in
                    self.tableView.reloadData() })
            }
        }
    }
}

    //initialize chatroom



    // create a function setting the image,messages, time equal to themselves




// MARK: - UITableViewDelegate
extension InboxTableViewController {
    
    
    //var chatroom : [ChatRoom]()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow
       
        let currentCell = tableView.cellForRow(at: indexPath!)
        
       let destinationViewController = MessageThreadViewController()
       navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension InboxTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inboxCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! InboxTableViewCell
        loadChatroomInfo(index: indexPath)
        return inboxCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return chatrooms.count
        return 3
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80.0)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func loadChatroomInfo(index: IndexPath) -> Void {
        print("Cell \(index) was loaded")
        
    }
    
    func chatroom(index: IndexPath , cell: InboxTableViewCell) -> Void {
       cell.chatFinalMessage = lastMessage
       //cell.chatRoomImage = chatrooms[index]
       //cell.chatMessageTime.text =
       //cell.chatRoomName =
        
        
    }
    
}
