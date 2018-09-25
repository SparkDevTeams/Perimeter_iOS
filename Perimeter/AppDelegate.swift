//
//  AppDelegate.swift
//  Perimeter
//
//  Created by Davone Barrett on 9/7/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import UIKit
import Firebase
<<<<<<< HEAD
=======
import FirebaseAuth

>>>>>>> a9532ebd31d8d9a1daf555ffed32df14da9926fe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Firebase Initialization
        FirebaseApp.configure()
<<<<<<< HEAD
        
        // configure tabbar bar view
        configureTabBarView()
        
        return true
=======
       
        // configure tabbar bar view
        configureTabBarView();
        
        FirebaseAPI().signIn(email: "user1@perimeter.com", password: "Password") { (error, user) in
            print("Fetched user \(user)")
            guard let user = user else {return}
            
            FirebaseAPI().getUserProfileFromUid(user.uid, completion: { (error, profile) in
                print("User display name \(profile?.displayName)")
            })
        }

    
        return true;
>>>>>>> a9532ebd31d8d9a1daf555ffed32df14da9926fe
    }
    
    func configureTabBarView() {
        let settingsVc = SettingsTableViewController(style: .grouped)
<<<<<<< HEAD
        let settingsNc = UINavigationController(rootViewController: settingsVc)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let inboxNc = sb.instantiateViewController(withIdentifier: "inboxVC") as! UINavigationController
=======
        let inboxVc = InboxTableViewController(style: .plain)
        
        let settingsNc = UINavigationController(rootViewController: settingsVc)
        let inboxNc = UINavigationController(rootViewController: inboxVc)
>>>>>>> a9532ebd31d8d9a1daf555ffed32df14da9926fe
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([inboxNc, settingsNc], animated: true)
        
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
<<<<<<< HEAD
        
        
        
        
=======
>>>>>>> a9532ebd31d8d9a1daf555ffed32df14da9926fe
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

