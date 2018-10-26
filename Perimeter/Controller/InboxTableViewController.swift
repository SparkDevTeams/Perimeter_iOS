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
import CodableFirebase

class InboxTableViewController: UITableViewController {
    //var chatrooms = [String]()
    var chatrooms = [ChatRoom]()
    
    private let cellIdentifer = "InboxCell"
    
    let firebase = FirebaseAPI()
    
    var chatRoomDocumentRef: CollectionReference?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        registerCell()
        
        loadChatRooms()
        
        title = "Chat Rooms"
        
        let dataBase = Firestore.firestore()
        
        chatRoomDocumentRef = dataBase.collection("ChatRooms")
        
        chatRoomDocumentRef?.addSnapshotListener({(snapshot,error) in

        do{
            
            var chatrooms = [ChatRoom]()
            
            let documents = snapshot!.documents

            for document in documents {
                
                let data = document.data()
                
                let chatroom = try FirestoreDecoder().decode(ChatRoom.self, from: data)
                
                chatrooms.append(chatroom)

            }
            self.chatrooms = chatrooms
            
            self.tableView.reloadData()
            
        }
        catch {
            
            print(error)
        }

    })
    }
    
    private func registerCell() {
        
        let nib = UINib(nibName: "InboxTableViewCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: cellIdentifer)
    }

    private func loadChatRooms(){
        
        firebase.fetchAllChatRooms{(chatrooms, error) in
            
            self.chatrooms = chatrooms
            
            for chatRoom in chatrooms{
                
                self.firebase.fetchMessagesForChatRoom(chatRoom, completion:
                    
                    {(messages,messagesRef,error) in
                        
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
       let chatRoom = chatrooms[indexPath.row]
       
       let destinationViewController = MessageTableViewController(chatRoom: chatRoom)
        
       navigationController?.pushViewController(destinationViewController, animated: true)
          }
}

extension InboxTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let inboxCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! InboxTableViewCell
        
        let chatRoom = chatrooms[indexPath.row]
        
        inboxCell.chatRoom = chatRoom
        
        return inboxCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return chatrooms.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80.0)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
        
    }
    
   
    
}
