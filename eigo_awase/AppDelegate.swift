//
//  AppDelegate.swift
//  eigo_awase
//
//  Created by y.okoshi on 2017/12/12.
//  Copyright © 2017年 english-society. All rights reserved.
//

import UIKit
import SwiftRater
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /// version管理
    var betaVersion = "-debug"
    var productionVersion: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String

    //interstitial用
    var InterstitialFlug = false
    
    
    var MondaiCategory = ""
    var MondaiRandom:[String] = []
    
    let firebasePlistName = "GoogleService-Info"
    let withApplicationID = "cca-app-pub-2571146153853390~7511216219"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let firbaseOptions = FirebaseOptions(contentsOfFile: Bundle.main.path(forResource: firebasePlistName, ofType: "plist")!) {
            FirebaseApp.configure(options: firbaseOptions)
        }
        // Initialize the Google Mobile Ads SDK.
        // Sample AdMob app ID: ca-app-pub-3940256099942544~1458002511
        GADMobileAds.configure(withApplicationID: withApplicationID)
        
    
    //SwiftRater
        SwiftRater.daysUntilPrompt = 3
        SwiftRater.usesUntilPrompt = 3
        SwiftRater.significantUsesUntilPrompt = 3
        SwiftRater.daysBeforeReminding = 2
        SwiftRater.showLaterButton = true
        SwiftRater.debugMode = false
        SwiftRater.appLaunched()
        
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

