//
//  AppDelegate.swift
//  beacons
//
//  Created by Sohil Kaushal on 11/9/19.
//  Copyright © 2019 Sohil Kaushal. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?

    let beaconManager = ESTBeaconManager()
    let beetrootUUID = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()

        self.beaconManager.startMonitoring(for: CLBeaconRegion(proximityUUID: UUID(uuidString: beetrootUUID)!,
                major: 30154, minor: 54532, identifier: "my desk"))

        let notifications = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]

        notifications.requestAuthorization(options: options) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        return true
    }

    func showNotifications(with title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.badge = 1
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: "Local Notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error Detected: \(error)")
            }
        }
    }

    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("A user entered the region")
        showNotifications(with: "Entered", body: "We have detected that you are near a beacon")
    }

    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        print("A user exited the region: \(region)")
        showNotifications(with: "Exit", body: "We have detected that you are exiting the beacon region")
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
