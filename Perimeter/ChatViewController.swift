//
//  ChatViewController.swift
//  Perimeter
//
//  Created by Cassandra Zuria on 9/8/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import UIKit

class ChatViewController: UITableViewController {
    @IBOutlet var chatView:UITableView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatView.delegate = self
        chatView.dataSource = self
        }
    
}

func numberOfSections(in tableview: UITableView)->Int{
    return 1
}
// MARK: - UITableViewDelegate
extension ChatViewController {

}

// MARK: - UITableViewDataSource
extension ChatViewController {
    
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
}

