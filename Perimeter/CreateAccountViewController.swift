//
//  CreateAccountViewController.swift
//  Perimeter
//
//  Created by Joshua Martinez on 10/16/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        print("Sign up button tapped")
    
        // validate required fields are not empty
        if (userNameTextField.text?.isEmpty)! ||
            (emailTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)! ||
            (confirmPasswordTextField.text?.isEmpty)!
        {
            // Display Alrt message and return
            displayMessage(userMessage: "All fields are required")
            return
        }
        
        // Validate Password
        if ((passwordTextField.text?.elementsEqual(confirmPasswordTextField.text!))! != true)
        {
            // Display an alert message and return
            displayMessage(userMessage: "PLease make sure the passwords match")
            return
        }
        
        // Create activity indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // position activity indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // if needed, you can prevent activity indicator from hiding when stopANimationg is called
        myActivityIndicator.hidesWhenStopped = false
        
        // start activity indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
    }
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                // code in this block will trigger when OK button tapped
                print("OK button Tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion:nil)
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
}
