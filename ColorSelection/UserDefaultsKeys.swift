//
//  UserDefaultsKeys.swift
//  ColorSelection
//
//  Created by sodas on 12/24/16.
//  Copyright © 2016 sodastsai. All rights reserved.
//

import Foundation

// Prepare an `enum` for listing string keys of user defaults

enum UserDefaultsKeys: String {
    case alreadyLaunched = "tw.sodas.color-selection.alreadyLaunched"
    case appOpenCount = "tw.sodas.color-selection.appOpenCount"
    case indexOfSelectedColor = "tw.sodas.color-selection.indexOfSelectedColor"
}

// Extend `UserDefaults` class to adopt our `UserDefaultsKeys` enum

extension UserDefaults {

    func bool(forKey defaultName: UserDefaultsKeys) -> Bool {
        return self.bool(forKey: defaultName.rawValue)
    }

    func set(_ value: Bool, forKey defaultName: UserDefaultsKeys) {
        self.set(value, forKey: defaultName.rawValue)
    }

    func integer(forKey defaultName: UserDefaultsKeys) -> Int {
        return self.integer(forKey: defaultName.rawValue)
    }

    func set(_ value: Int, forKey defaultName: UserDefaultsKeys) {
        self.set(value, forKey: defaultName.rawValue)
    }

}
