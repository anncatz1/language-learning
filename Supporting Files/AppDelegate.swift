//
//  AppDelegate.swift
//  Sleep Learning
//
//  Created by Mani Jahani on 6/4/19.
//  Copyright © 2019 Memory Lab. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        //  Check to see if a user is logged in
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            //  If no user is logged in: launch with loginVC
            if user == nil {
                print("No user logged in")
                //  loginVC is the default
            }
            //  If there is a user logged in: launch with instructionsVC
            else {
                print("Logged in with user email: \(user!.email!)")
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let instructionsVC = sb.instantiateViewController(withIdentifier: "instructionsVC")
                self.window?.rootViewController = instructionsVC
                self.window?.makeKeyAndVisible()

                // Set the assigned language
                setAssignedLanguage()
                return
            }
        }
        return true
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

