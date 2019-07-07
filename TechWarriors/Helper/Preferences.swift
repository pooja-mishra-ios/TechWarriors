//
//  Preferences.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 05/07/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

class Preferences: NSObject {
    
    // MARK: - Properties
    private static var sharedPreferences: Preferences = {
        let preferences = Preferences()
        return preferences
    }()
    
    // MARK: - Accessors
    class func shared() -> Preferences {
        return sharedPreferences
    }
    
    func setPreference(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getPreference(key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    func removePreference(key: String) {
        UserDefaults.standard.removeObject(forKey:key)
        UserDefaults.standard.synchronize()
    }
}
