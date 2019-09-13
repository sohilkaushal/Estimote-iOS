//
//  AppDelegate.swift
//  beacons
//
//  Created by Sohil Kaushal on 11/9/19.
//  Copyright © 2019 Sohil Kaushal. All rights reserved.
//

import UIKit
import UserNotifications

import EstimoteProximitySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var proximityObserver: ProximityObserver!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
        let cloudCredentials = CloudCredentials(appID: "ios-notification-5np",
                                                appToken: "e0e4ce45083bed89e656e583e230ebee")
        self.proximityObserver = ProximityObserver(credentials: cloudCredentials, onError: { (error) in
            print("Error in ProximityObserver \(error)")
        })
        
        let zone = ProximityZone(tag: "WorkDesk", range: .near)
        zone.onEnter = { context in
            let deskOwner = context.attachments["desk-owner"]
            print("Welcome to \(String(describing: deskOwner))'s desk")
        }
        
        zone.onExit = { _ in
            print("Bye Bye")
        }
        
        self.proximityObserver.startObserving([zone])
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
