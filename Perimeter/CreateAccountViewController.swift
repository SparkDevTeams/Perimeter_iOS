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
    
    
//    @IBAction func signupButtonTapped(_ sender: Any) {
//        print("Sign up button tapped")
//        
//        // validate required fields are not empty
//        if (userNameTextField.text?.isEmpty)! ||
//            (emailTextField.text?.isEmpty)! ||
//            (passwordTextField.text?.isEmpty)! ||
//            (confirmPasswordTextField.text?.isEmpty)!
//        {
//            // Display Alrt message and return
//            displayMessage(userMessage: "All fields are required")
//            return
//        }
//        
//        // Validate Password
//        if ((passwordTextField.text?.elementsEqual(confirmPasswordTextField.text!))! != true)
//        {
//            // Display an alert message and return
//            displayMessage(userMessage: "PLease make sure the passwords match")
//            return
//        }
//        
//        // Create activity indicator
//        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
//        
//        // position activity indicator in the center of the main view
//        myActivityIndicator.center = view.center
//        
//        // if needed, you can prevent activity indicator from hiding when stopANimationg is called
//        myActivityIndicator.hidesWhenStopped = false
//        
//        // start activity indicator
//        myActivityIndicator.startAnimating()
//        
//        view.addSubview(myActivityIndicator)
//        
//        // send HTTP Request to register user
//        let myUrl = URL(string: "http://localhost:8080/api/users")
//        var request = URLRequest(url:myUrl!)
//        request.httpMethod = "POST" // compose a query string
//        request.addValue("application/json", forHTTPHeaderField: "content-type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        let postString = ["userName": userNameTextField.text!,
//                          "userEmail": emailTextField.text!,
//                          "userPassword": passwordTextField.text!,
//                          ] as [String: String]
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//            displayMessage(userMessage: "Something went wrong. Try again.")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//            
//            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
//            
//            if error != nil {
//                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
//                print("error=\(String(describing: error))")
//                return
//            }
//            // Let's convert response sent from a server side code to a NSDictionary object:
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//                
//                if let parseJSON = json {
//                    
//                    let userId = parseJSON["userId"] as? String
//                    print("User id: \(String(describing: userId!))")
//                    
//                    if (userId?.isEmpty)!
//                    {
//                        // Display an Alert dialog with a friendly error message
//                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
//                        return
//                    } else {
//                        self.displayMessage(userMessage: "Successfully Registered a New Account. Please proceed to Sign in")
//                    }
//                    
//                } else {
//                    // Display an Alert dialog with a friendly error message
//                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
//                }
//            } catch {
//                
//                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
//                
//                // Display an Alert dialog with a friendly error message
//                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
//                print(error)
//            }
//        }
//        
//        task.resume()
//    }
//    
//    
//    
//    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
//    {
//        DispatchQueue.main.async {
//            activityIndicator.stopAnimating()
//            activityIndicator.removeFromSuperview()
//        }
//    }
//    
//    func displayMessage(userMessage:String) -> Void {
//        DispatchQueue.main.async {
//            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
//            
//            let OKAction = UIAlertAction(title: "OK", style: .default) {
//                (action:UIAlertAction!) in
//                // code in this block will trigger when OK button tapped
//                print("OK button Tapped")
//                DispatchQueue.main.async {
//                    self.dismiss(animated: true, completion:nil)
//                }
//            }
//            alertController.addAction(OKAction)
//            self.present(alertController, animated: true, completion:nil)
//        }
//    }
    
    @IBAction func signinPressed(_ sender: Any) {
        let signupSB = UIStoryboard(name: "Signup", bundle: nil)
        
        let signupVC = signupSB.instantiateViewController(withIdentifier: "SignupVC")
        show(signupVC, sender: self)
    }
}
