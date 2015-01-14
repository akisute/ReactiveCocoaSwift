//
//  AppDelegate.swift
//  ReactiveCocoaSwift
//
//  Created by 小野 将司 on 2015/01/04.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let navigationController = self.window?.rootViewController as UINavigationController
        let listViewController = navigationController.topViewController as ListViewController
        listViewController.presentation = ListViewControllerPresentation(document: Document())
        
        return true
    }
}

