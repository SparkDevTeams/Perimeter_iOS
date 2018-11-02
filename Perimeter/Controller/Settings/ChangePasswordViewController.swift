//
//  ChangePasswordViewController.swift
//  Perimeter
//
//  Created by Davone Barrett on 10/10/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import UIKit

class ChangePasswordViewController: UITableViewController {
    
    @IBOutlet weak var changePassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    var userProfile = UserProfile.currentUserProfile
    
    private func setupNavigationBar() {
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveChanges))
        navigationItem.setRightBarButton(saveButton, animated: true)
        
        
    }
    
    @objc func saveChanges() {
        print("Saving user changes ")
        
        
        if (changePassword.text != confirmPassword.text){
             print("Password needs to be the same")
            let alertController = UIAlertController(title: "Error!", message: "Passwords are not the same", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okay)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        if (changePassword.text == confirmPassword.text){
            let alertController = UIAlertController(title: "Success", message: "Your new password was saved successfully", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okay)
            self.present(alertController, animated: true, completion: nil)
            performSegue(withIdentifier: "save", sender: self)
            
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        changePassword.delegate = self
        confirmPassword.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    changePassword.resignFirstResponder()
    confirmPassword.resignFirstResponder()
        print("Touched outside")
    }
    
    
}
extension ChangePasswordViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
