//
//  EditProfileController.swift
//  Perimeter
//
//  Created by Kristian Chisholm on 9/27/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import Firebase

class EditProfileTableViewController: UITableViewController {
    
    let userProfile = UserProfile.currentUserProfile
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    private func setupNavigationBar() {
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveChanges))
        navigationItem.setRightBarButton(saveButton, animated: true)
    }
    
    @objc func saveChanges() {
        //createAlert(title: "SUCCESS", message: "You have saved succesfully")
        print("Saving user changes ")
        
        if let userId = Auth.auth().currentUser?.uid {
            FirebaseAPI().changeDisplayName(newDisplayName: displayNameTextField.text!, uid: userId) { (error) in
                print("User name changed")
                UserProfile.currentUserProfile?.displayName = self.displayNameTextField.text!
                
                
                //Firstname and Lastname methods
                self.userProfile?.firstName = self.firstName.text!
                self.userProfile?.lastName = self.lastName.text!
                
                UserProfile.currentUserProfile = self.userProfile
                
                
                let alertController = UIAlertController(title: "Success", message: "Display name has been changed", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okay)
                self.present(alertController, animated: true, completion: nil)
            }
            
            
            
            //navigationController?.popViewController(animated: true)
        }
        
        
        
        
        
        
        
        
        //performSegue(withIdentifier: "Save", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        self.displayNameTextField.text = userProfile?.displayName
        
//
//        if let imageUrl = URL(string: (userProfile?.profileImageUrl)!) {
//            let resouce =
//                userProfileImageView.kf.setImage(with: imageUrl)
//        }
            userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.width/2
            userProfileImageView.clipsToBounds = true
        
        displayNameTextField.text = userProfile?.displayName
    
    }
    
    @IBAction func editProfilePicturePressed(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        //Allows the user to pick a picture from the photo library.
        // Checks if user has a camera if not sends a message camera is unavailable.
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler:  {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else {
                print("Camera is not available")
            }
        }))
        //Allows the user to pick a picture from the photo library.
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:  {(action:UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension EditProfileTableViewController {

}

// MARK: - UIImagePickerControllerDelegate
extension EditProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userProfileImageView.image = image
            let imageUrl = info[UIImagePickerControllerImageURL] as? URL
            print("image url is \(imageUrl?.absoluteString)")
            FirebaseAPI().uploadImage(path: imageUrl!.absoluteString) { (url,error) in
                if error == nil{
                    UserProfile.currentUserProfile?.profileImageUrl = url
                }
            }
            
            let imageUrl = info[UIImagePickerControllerImageURL] as? String
        } else {
            //Error Message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
