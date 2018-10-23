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
    
    private let cellIdentifer = "InboxCell"
    
    let firebase = FirebaseAPI()
    
    var chatRoomDocumentRef: CollectionReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        //loadChatRooms()
        title = "Chat Rooms"
        
//        let dataBase = Firestore.firestore()
//        chatRoomDocumentRef = dataBase.collection("ChatRooms")
//        chatRoomDocumentRef?.addSnapshotListener({(snapshot,error) in
//
//
//        do{
//            var chatrooms = [ChatRoom]()
//            let documents = snapshot!.documents
//
//            for document in documents {
//                let data = document.data()
//                let jsonData = try  JSONSerialization.data(withJSONObject: data, options: [])
//                let chatroom = try JSONDecoder().decode(ChatRoom.self, from: jsonData)
//                chatrooms.append(chatroom)
//
//            }
//            self.chatrooms = chatrooms
//            self.tableView.reloadData()
//        }
//        catch {
//            print(error)
//
//        }
//
//    })
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "InboxTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifer)
    }

    private func loadChatRooms(){
        
        firebase.fetchAllChatRooms{(chatrooms, error) in
            self.chatrooms = chatrooms
            
            for chatRoom in chatrooms{
                self.firebase.fetchMessagesForChatRoom(chatRoom, completion: {(messages,messagesRef,error) in
                    self.tableView.reloadData() })
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension InboxTableViewController {
    
    
    //var chatroom : [ChatRoom]()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //let indexPath = tableView.indexPathForSelectedRow
       
        let currentCell = tableView.cellForRow(at: indexPath)
        //messageVC will be provided by Davone!
       //let destinationViewController = MessageTableViewController(chatRoom: ChatRoom)
        
       let destinationViewController = MessageThreadViewController()
       navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension InboxTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inboxCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! InboxTableViewCell
        
        loadChatroomInfo(index: indexPath)
        //let chatRoom = chatrooms[indexPath.row]
        
        //inboxCell.chatRoom = chatRoom
        
    
        return inboxCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return chatrooms.count
        return 3
            //chatrooms.count
        
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
    
    
}
