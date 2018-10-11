//
//  SettingsTableViewController.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/8/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewController: UITableViewController {
    // This is where you allow or deny notifictaions
    // made by nathercia goncalves
    
    
    //@IBAction func notificationSwitch(_ sender: UISwitch)
    //{
    
    
    @IBAction func notificationSwitch(_ sender: UISwitch) {
        
        if(sender.isOn == true)
        {
            let alert = UIAlertController(title: "Push notifications turned on", message: "Your push notifications have been turned on, disable at any time in setting", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK",style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Push notifications turned off", message: "If you turn off notifications for this app, you may miss important alerts and updates", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style:.default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }
    
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension SettingsTableViewController {
    
}

