//
//  EditProfileController.swift
//  Perimeter
//
//  Created by Kristian Chisholm on 9/27/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import UIKit

class EditProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    private func setupNavigationBar() {
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveChanges))
        navigationItem.setRightBarButton(saveButton, animated: true)
    }
    
    @objc func saveChanges() {
        print("Saving user changes ")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
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
extension EditProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userProfileImageView.image = image
        } else {
            //Error Message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
