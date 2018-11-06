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
        super.viewDidLoad()
        
        let tapGues = UITapGestureRecognizer()
        tapGues.numberOfTapsRequired = 1
        tapGues.numberOfTouchesRequired = 1
        tapGues.addTarget(self, action: #selector(dissmissKeyboard))
        
        view.addGestureRecognizer(tapGues)
    }
    
    @objc private func dissmissKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func validate(field: UITextField) -> String?{
        guard let trimmedText = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return nil
        }
        
        guard let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else{
            return nil
        }
        
        let range = NSMakeRange(0, NSString(string: trimmedText).length)
        let allMatches = dataDetector.matches(in: trimmedText, options: [], range: range)
        
        if allMatches.count == 1,
            allMatches.first?.url?.absoluteString.contains("mailto:") == true
        {
            return trimmedText
        }
        
        return nil
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
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
        
        FirebaseAPI().signIn(email: emailTextField.text!, password: passwordTextField.text!) { (error, user) in
            
            if error == nil {
                let appDel = UIApplication.shared.delegate as! AppDelegate
                appDel.showMain()
                
                FirebaseAPI().signIn(email: self.emailTextField.text!, password: self.passwordTextField.text!) { (error, user) in
                    if (error != nil){
                        
                        print(error?.localizedDescription)
                    }else{
                        guard let userId = user?.uid else {return}
                        
                        FirebaseAPI().getUserProfileFromUid(userId, completion: { (error, userProfile) in
                            if (error != nil) {
                                print(error?.localizedDescription)
                            } else {
                                UserProfile.currentUserProfile = userProfile
                            }
                        })
                    }
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Email or password is incorrect", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(okay)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    

    @IBAction func createOnePressed(_ sender: Any) {
        let createAccountSB = UIStoryboard(name: "CreateAccount", bundle: nil)
        
        let createAccountVC = createAccountSB.instantiateViewController(withIdentifier: "CreateAccountViewController")
        show(createAccountVC, sender: self)
    }

}
