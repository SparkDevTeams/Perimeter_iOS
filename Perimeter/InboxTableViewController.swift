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
    
    let messages = ["Poop", "Nuugest"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Perimeter"
        registerCell()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "InboxTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "inboxCell")
    }
}

// MARK: - UITableViewDelegate
extension InboxTableViewController {
    
    
}

// MARK: - UITableViewDataSource
extension InboxTableViewController {
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
        
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatView = ChatViewController()
        
        navigationController?.pushViewController(chatView, animated: true)
    }
}

