//
//  AppDelegate.swift
//  Maidpicker
//
//  Created by Apple on 05/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseMessaging
import UserNotifications
import FirebaseInstanceID
//import RealmSwift
//
//var realmfile = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        GMSServices.provideAPIKey("AIzaSyBub0VudxANj6mQET4ai5H_ZVKX9G34qrw")
        GMSPlacesClient.provideAPIKey("AIzaSyDMb7su23CaRcyJBhnjdcriS3qRBvSVHfI")
        
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.8387052417, green: 0.3671816587, blue: 0.3520277441, alpha: 1)
        UITabBar.appearance().backgroundColor = UIColor.white
        
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
        
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

    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("Message ID: \(userInfo["gcm_message_id"])")
        
        print("this is user INFORMATION: \(userInfo)")
        
        
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let apptVC = storyboard.instantiateViewController(withIdentifier: "gotoAnteupVC") as! AnteUpVC
//        let gameID = userInfo["gameid"] as! String
//        let preferences = UserDefaults.standard
//        preferences.set(true, forKey: "notificationClickcheck")
//        preferences.set(gameID, forKey: "SP_gameid")
//        preferences.synchronize()
//        print("Call from app delegate: \(gameID)")
//        apptVC.userinGroupID = gameID
//
//        self.window?.rootViewController = apptVC
//        self.window?.makeKeyAndVisible()
        
    }
    
}

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
        UserDefaults.standard.synchronize()
        
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        
    }
    // [END ios_10_data_message]
}
