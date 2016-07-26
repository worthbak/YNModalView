//
//  AppDelegate.swift
//  YNModalViewExample
//
//  Created by David Baker on 1/15/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    self.window = UIWindow(frame: UIScreen.main().bounds)
    
    let viewController = ViewController()
    let navController = UINavigationController(rootViewController: viewController)
    
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    
    return true
  }

}

