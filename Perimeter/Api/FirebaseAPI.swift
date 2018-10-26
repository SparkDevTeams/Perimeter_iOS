//
//  FirebaseAPI.swift
//  Perimeter
//
//  Created by Cristina Alonso on 9/18/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase
/// Class to interact with firebase API
class FirebaseAPI{
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    /// Call this method to attempt to sign in a user
    ///
    /// - Parameters:
    ///   - email: The email to sign in with
    ///   - password: The password to sign in with
    ///   - completion: A block of code to execute once the the sign in is successful or failed. Retuns a Error and a Firebase User
    
    
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
    
    
    public func changeDisplayName(newDisplayName: String, uid: String, completion: @escaping (Error?) -> Void) {
        // get a reference to the specific user document and fetch the documents
        let dbRef = db.collection("Users").document(uid)
        dbRef.getDocument { (snapshot, error) in
            // there was a error
            if error != nil {
                completion(error)
                return

            } else {
                dbRef.updateData(["displayName":newDisplayName])
                self.getUserProfileFromUid(uid, completion: {(error,profile) in
                    completion(nil)

                });
            }
        }
    }
    
    public func changeFirstName(newFirstName: String, uid: String, completion: @escaping (Error?) -> Void) {
        // get a reference to the specific user document and fetch the documents
        let dbRef = db.collection("Users").document(uid)
        dbRef.getDocument { (snapshot, error) in
            // there was a error
            if error != nil {
                completion(error)
                return
                
            } else {
                dbRef.updateData(["firstName":newFirstName])
                self.getUserProfileFromUid(uid, completion: {(error,profile) in
                    completion(nil)
                    
                });
            }
        }
    }
    public func changeLastName(newLastName: String, uid: String, completion: @escaping (Error?) -> Void) {
        // get a reference to the specific user document and fetch the documents
        let dbRef = db.collection("Users").document(uid)
        dbRef.getDocument { (snapshot, error) in
            // there was a error
            if error != nil {
                completion(error)
                return
                
            } else {
                dbRef.updateData(["lastName":newLastName])
                self.getUserProfileFromUid(uid, completion: {(error,profile) in
                    completion(nil)
                    
                });
            }
        }
    

    //sends message to specified chatroom and updates last message in chat room
    func sendMessage(message: Message, chatRoom: ChatRoom, completion: @escaping (Error?)->Void){
        
        let chatRef = db.collection("ChatRooms").document(chatRoom.id)
        chatRef.updateData(["lastMessage": message.dictionary])
        
        let dbRef = db.collection("Messages").document(chatRoom.currentMessagesId)
    
        dbRef.getDocument{ (snapShot,error) in
            if error == nil{
                if let data = snapShot?.data(), let messages = data["messages"]{
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: messages, options:[])
                        var messages = try JSONDecoder().decode([Message].self, from: jsonData)
                        messages.append(message)
                        
                        let newMessagesData = try JSONEncoder().encode(messages)
                        let newMessages  = try JSONSerialization.jsonObject(with: newMessagesData, options:[])
                        dbRef.updateData(["messages" : newMessages])
                         completion(nil)
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
            }
            else{
                completion(error)
            }
        }
                   
    }
    
    
  

    /// Fetchs all the chatrooms from firebase
    ///
    /// - Parameter completion: a block of code to execute when all the chat rooms have been fetched
     func fetchAllChatRooms(completion: @escaping ([ChatRoom], Error?) -> Void) {
        let chatroomRef = db.collection("ChatRooms")
        chatroomRef.getDocuments { (querySnapshot, error) in
            if error != nil {
                print("Error fetching documents")
                completion([], error)
            } else {
                
                do {
                    var chatRooms = [ChatRoom]()
                    
                    let documents = querySnapshot!.documents
                    
                    for document in documents {
                        let data = document.data()
                        let chatroom = try FirestoreDecoder().decode(ChatRoom.self, from: data)
                        chatRooms.append(chatroom)
                    }
                    
                    completion(chatRooms, nil)
                    
                } catch {
                    print(error)
                }
                
            }
        }
    }
    
    
     /// fetches all the messages for the passed in chatroom
     ///
     /// - Parameters:
     ///   - chatRoom: The chatroom to fetch the messages from
     ///   - completion: A block of code to execute when all the messages have been fetch
     func fetchMessagesForChatRoom(_ chatRoom: ChatRoom, completion: @escaping ([Message], DocumentReference, Error?) -> Void) {
        // get document ref and fetch
        let messsagesRef = db.collection("Messages").document(chatRoom.currentMessagesId)
        messsagesRef.getDocument { (snapshot, error) in
            
            if error != nil {
                completion([],messsagesRef, error)
                return
            }
            
            if let snapshotData = snapshot?.data(), let snapshotMessages = snapshotData["messages"] as? [[String: Any]]{
                
                var messages = [Message]()
                
                for snapshotMessage in snapshotMessages {
                    do {
                        let message = try FirestoreDecoder().decode(Message.self, from: snapshotMessage)
                        messages.append(message)
                    } catch {
                        print(error)
                        completion(messages,messsagesRef, error)
                    }
                }
                completion(messages, messsagesRef, nil)
            }
        }
    }
    
<<<<<<< HEAD
    func uploadImage(path: String, completion: @escaping (String,Error?) -> Void) {
    // File located on disk
    let localFile = URL(string: path)!
    let storageRef = storage.reference()

    // Create a reference to the file you want to upload
   // let riversRef = storageRef

    // Upload the file to the path "images/rivers.jpg"
    let uploadTask = storageRef.putFile(from: localFile, metadata: nil) { metadata, error in
        guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
        }
        // Metadata contains file metadata such as size, content-type.
        let size = metadata.size
        // You can also access to download URL after upload.
        storageRef.downloadURL { (url, error) in
            if error == nil{
                completion(url!.absoluteString, nil)
            }
            else{
                completion("", error)
            }
            }

        }
        }




    typealias Completion = (Error?) -> Void
    
    func changePassword(email: String, currentPassword: String, newPassword: String, completion: @escaping Completion) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (error) in
            if error == nil {
                let user = Auth.auth().currentUser
                user?.updatePassword(to: newPassword) { (errror) in
                    completion(errror)
                }
            } else {
                completion(error)
            }
        })
    }

=======
    func sendTextMessage(_ messageToSend: Message, inChatRoom chatRoom: ChatRoom, completion: @escaping (()->())) {
        let lastMessage = try! FirebaseEncoder().encode(messageToSend)
        print(messageToSend.dictionary)
        print(messageToSend)
        print(lastMessage)
        // first get a ref to the chatroom
        let chatRoomRef = db.collection("ChatRooms").document(chatRoom.id)
        chatRoomRef.updateData(["lastMessage": messageToSend.dictionary])
        
        // add the message to the messages
        let messsagesRef = db.collection("Messages").document(chatRoom.currentMessagesId)
        messsagesRef.getDocument { (snapshot, error) in
            
            if error != nil {
                print("There was a error")
                completion()
                return
            }
            
            if let snapshotData = snapshot?.data(), var snapshotMessages = snapshotData["messages"] as? [[String: Any]]{
                
                snapshotMessages.append(messageToSend.dictionary)
                messsagesRef.updateData(["messages": snapshotMessages])
                completion()
            }
        }
    }
    
>>>>>>> dev
}
    
}

