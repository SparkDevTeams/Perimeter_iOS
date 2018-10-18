//
//  signUpScreen.swift
//  Perimeter
//
//  Created by Eduardo Paredes on 9/13/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//
import Foundation
import UIKit

class SignUpScreenViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        //FirebaseAPI().createAccount(profile: "diago@email.com", password: "password") { (_, _) in
        
    }
    
    //super.viewDidLoad()
}

extension SignUpScreenViewController {
    
    //override func viewDidLoad() {
      //  FirebaseAPI().createAccount(profile: "diago@gmail.com", password: "password", completion: ())
    //}
    
    func validate(field: UITextField) -> String?{
        //guard let trimmedText = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return nil
        //}
        
        guard let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else{
            return nil
        }
        
        let range = NSMakeRange(0, trimmedText.count)
        let allMatches = dataDetector.matches(in: trimmedText, options: [], range: range)
        
        if allMatches.count == 1,
            allMatches.first?.url?.absoluteString.contains("mailto:") == true
        {
            return trimmedText
        }
        
        return nil
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        //var userType = login.checkPrivs()
        
        let userEmail = emailTextField.text;
        let userPassword = passwordTextField.text;
        
        let alert = UIAlertController(title: "Oops! Not so fast.", message: "Please make sure you enter both your email and your password", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        //checking empty fields
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)!){
            present(alert, animated: true, completion: nil)
            return
        }
        
        if validate(field: emailTextField) == nil {
            let alert = UIAlertController(title: "Whoops! Invalid email.", message: "Please enter valid email", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        FirebaseAPI().signIn(email: userEmail!, password: userPassword!){(success, userEmail) in
            print("signed in!")
            print(success, userEmail)
        }
        
    }
    
    @IBAction func createAccountButton(_ sender: UIButton) {
        
    }
    
}
