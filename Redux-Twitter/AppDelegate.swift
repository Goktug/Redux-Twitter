//
//  AppDelegate.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 25.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import UIKit
import TwitterKit
import ReSwift
import ReSwiftRouter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Set a dummy view controller to satisfy UIKit
    window?.rootViewController = UIViewController()
    
    let rootRoutable = RootRoutable(window: window!)
    
    // Set Router
    router = Router(store: store, rootRoutable: rootRoutable) {
      $0.select {
        $0.navigationState
      }
    }
    
    // Twitter Config
    TWTRTwitter.sharedInstance().start(withConsumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    
    //LoginProvider.logOut()
    
    // Start with splash screen (a.k.a Login screen)
    store.dispatch(ReSwiftRouter.SetRouteAction([RouteNames.splash]))
      
    window?.makeKeyAndVisible()
    
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
  }
}
