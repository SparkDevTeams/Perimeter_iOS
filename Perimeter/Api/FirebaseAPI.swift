//
//  FirebaseAPI.swift
//  Perimeter
//
//  Created by Cristina Alonso on 9/18/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import Firebase

/// Class to interact with firebase API
class FirebaseAPI{
    
    private let db = Firestore.firestore()
    
    /// Call this method to attempt to sign in a user
    ///
    /// - Parameters:
    ///   - email: The email to sign in with
    ///   - password: The password to sign in with
    ///   - completion: A block of code to execute once the the sign in is successful or failed. Retuns a Error and a Firebase User
    public func signIn(email: String, password: String, completion: @escaping (Error?, User?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            // check to see if there where any error, if so foward to completion handler and return to get out of function
            if error != nil {
                completion(error, nil)
                return
            }
            
            if let user = authDataResult?.user {
                completion(nil, user)
                return
            }
        }
    }
    
    public func createAccount(profile: UserProfile, password: String, completion: @escaping(Error?,User?)-> Void){
        
        Auth.auth().createUser(withEmail: profile.email, password: password) { (authResult, error) in
    
            if error != nil{
                completion(error,nil)
                return
            }
            
            if let user = authResult?.user{
                let documentRef = self.db.collection("Users").document(user.uid)
                var dictionary = profile.dictionary
                dictionary.updateValue(documentRef.documentID, forKey:"id")
                documentRef.setData(dictionary)
                completion(nil,user)
                return
            }
        }
    }
    
    /// Gets a userProfile from a specific userId
    ///
    /// - Parameters:
    ///   - uid: The uid
    ///   - completion: A block of code to exeucte once the user profile has been fetched. 
    public func getUserProfileFromUid(_ uid: String, completion: @escaping (Error?, UserProfile?) -> Void) {
        // get a reference to the specific user document and fetch the documents
        let dbRef = db.collection("Users").document(uid)
        dbRef.getDocument { (snapshot, error) in
            // there was a error
            if error != nil {
                completion(error, nil)
                return
                
            } else {
                // gaurd to make sure snapshot has data
                guard let retrievedData = snapshot?.data() else {
                    // something is wrong with the data
                    let errorTemp = NSError(domain:"", code: 1, userInfo:nil)
                    completion(errorTemp, nil)
                    return
                }
                
                // now retrievedData is no longer a optional
                do {
                    let data = try JSONSerialization.data(withJSONObject: retrievedData, options: [])
                    let userProfile = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(nil, userProfile)
                    
                } catch {
                    let errorTemp = NSError(domain:"", code: 1, userInfo:nil)
                    completion(errorTemp, nil)
                    return
                }
            }
        }
    }
}
