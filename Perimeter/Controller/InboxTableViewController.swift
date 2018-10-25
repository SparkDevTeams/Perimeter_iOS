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
    //var chatrooms = [String]()
    var chatrooms = [ChatRoom]()

    let cellIdentifer = "InboxCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        title = "Chatrooms"
    }
    
    func registerCell() {
        let nib = UINib(nibName: "InboxTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifer)
    }
}
// MARK: - UITableViewDelegate
extension InboxTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow
       
        let currentCell = tableView.cellForRow(at: indexPath!)
        
//        let destinationViewController = MessageTableViewController()
//       navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension InboxTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inboxCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! InboxTableViewCell
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
