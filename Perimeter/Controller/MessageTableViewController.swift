//
//  ChatViewController.swift
//  Perimeter
//
//  Created by Cassandra Zuria on 9/8/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class MessageTableViewController: UITableViewController {
    
    let messageCellId = "MessageCellId"
    
    let chatRoom: ChatRoom
    var messages = [Message]()
    
    let messageBar = MessageInputBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        loadMessages()
        tabBarController?.tabBar.isHidden = true
        configureMessageBar()
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        title = chatRoom.location
        listenForNewMessages()
        setupNavButton()
    }
    
    private func configureMessageBar() {
        view.addSubview(messageBar)
        messageBar.delegate = self
    }
    
    init(chatRoom: ChatRoom) {
        self.chatRoom = chatRoom
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use chatroom contructor")
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "MessageTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: messageCellId)
    }
    
    private func setupNavButton() {
        let infoButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showChatRoomDetail))
        navigationItem.setRightBarButton(infoButton, animated: true)
    }
    
    @objc private func showChatRoomDetail() {
        let threadDetail = MessageThreadDetailViewController(chatRoom: chatRoom)
        navigationController?.pushViewController(threadDetail, animated: true)
    }
    
    private func loadMessages() {
        FirebaseAPI().fetchMessagesForChatRoom(chatRoom) { (messages, docRef, error) in
            self.messages = messages
            self.tableView.reloadData()
        }
    }
    
    private func listenForNewMessages() {
        let db = Firestore.firestore()
        let messagesDocRef = db.collection("Messages").document(chatRoom.currentMessagesId)
        messagesDocRef.addSnapshotListener { (snapshot, error) in
            
            if error != nil {
                print("Error listening for changes")
            } else {
                if let snapshotData = snapshot?.data(), let snapshotMessages = snapshotData["messages"] as? [[String: Any]]{
                    
                    var messages = [Message]()
                    
                    for snapshotMessage in snapshotMessages {
                        do {
                            let message = try FirestoreDecoder().decode(Message.self, from: snapshotMessage)
                            messages.append(message)
                        } catch {
                            print(error)
                        }
                    }
                    self.messages = messages
                    self.tableView.reloadData()
                    
                } else{
                    let tempError = NSError(domain: "Could not decode messsage", code: 1, userInfo: nil)
                    print(tempError)
                    return
                }
            }
            
        }
    }
}


// MARK: - UITableViewDelegate && UITableViewDataSource
extension MessageTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageCell = tableView.dequeueReusableCell(withIdentifier: messageCellId, for: indexPath) as! MessageTableViewCell
        let message = messages[indexPath.row]
        
        messageCell.message = message
        
        return messageCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


extension MessageTableViewController: MessageInputDelegate {
    func userDidPressSendButton(message: String?) {
        let messageId = UUID().uuidString
        let senderId = Auth.auth().currentUser!.uid
        let userDisplayName = "Ashy"
        let messageOne = Message(timestamp: Timestamp.init(), message: message, senderId: senderId, messageType: "text", audioLink: nil, imageLink: nil, videoLink: nil, chatRoomId: chatRoom.id, messageId: messageId, senderDisplayName: userDisplayName)
        
        print(Date().timeIntervalSince1970)
        
        FirebaseAPI().sendTextMessage(messageOne, inChatRoom: chatRoom) {
            
        }
    }
    
    func userDidPressCameraButton() -> UIImage? {
        
        return nil
    }
}

