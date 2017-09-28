//
//  AppDelegate.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 9/26/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url.description)
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "4xNvYjA8PFwogWxMDZgOPIMeA", consumerSecret: "ynYmrqAumMFs6eg2Yk1K4Hu6rHa17iYuJs8IgHENKAxH0OAOUC")
        
        twitterClient?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken!, success: { (accessToken) in
            print("gotted an access token for a user")
            twitterClient?.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil,  success: { (task, response) in
                // do nothing
                let userDict = response as! NSDictionary
                let user = User(userDict: userDict)
                
            }, failure: { (taks, error) in
         
            })
            
            twitterClient?.get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil,  success: { (task, response) in
                // do nothing
                let tweetDicts = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(tweetDicts: tweetDicts)
                
                
            }, failure: { (taks, error) in
                
            })
        }, failure: { (error) in
            if let error = error {
                print(error)
            }
        })
        return true
    }


}

