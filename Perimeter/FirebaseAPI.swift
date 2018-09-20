//
//  FirebaseAPI.swift
//  Perimeter
//
//  Created by Cristina Alonso on 9/18/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAPI{
    
    let db = Firestore.firestore()
    
    func signIn(email: String, password: String, completion: @escaping (Bool?, String?) -> Void) {
        
        var uid = "";
        var logInSuccessful = false
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil{
                debugPrint("Logged in with uid: " + user!.user.uid)
                uid = user!.user.uid
                logInSuccessful = true
                completion(logInSuccessful, uid)
            }
            else{
                debugPrint("Wrong username or password");
                completion(nil, nil)
            }
        }
    }
    
    func getUserProfile(_ userId: String, completion: @escaping (PerimeterUserProfile?) -> Void){
    
        db.collection("Users").document(userId).getDocument { (snapshot, error) in
            
            if error == nil{
                guard let data = snapshot?.data() else {return}
                let user = PerimeterUserProfile(firstName: data["firstName"] as! String, lastName: data["lastName"] as! String, email: data["email"] as! String, profileImageUrl: data["imageUrl"] as? String, displayName: data["displayName"] as! String)
                completion(user);
            }
            else{
                debugPrint("No account with uid " + userId);
                completion(nil);
            }
        }
    }
    
    
    
}
