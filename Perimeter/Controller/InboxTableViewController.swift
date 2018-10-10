//
//  InboxTableViewController.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/8/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import UIKit

class InboxTableViewController: UITableViewController {
    
    var chatrooms = ChatRoom.testChatRooms()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK: - UITableViewDelegate
extension InboxTableViewController {
    
}

// MARK: - UITableViewDataSource
extension InboxTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return chatrooms.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        return cell
    }
    
