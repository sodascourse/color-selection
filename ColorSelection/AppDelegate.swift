//
//  AppDelegate.swift
//  ColorSelection
//
//  Created by sodas on 12/24/16.
//  Copyright © 2016 sodastsai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: - App Delegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.increaseAppOpenCount()
        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        self.increaseAppOpenCount()
    }

    // MARK: - Methods

    func increaseAppOpenCount() {
        var currentAppOpenCount = UserDefaults.standard.integer(forKey: .appOpenCount)
        currentAppOpenCount += 1
        UserDefaults.standard.set(currentAppOpenCount, forKey: .appOpenCount)
    }

}
