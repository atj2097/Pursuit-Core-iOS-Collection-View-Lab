//
//  UserDefaultWrapper.swift
//  collectionViewLab
//
//  Created by God on 9/27/19.
//  Copyright © 2019 God. All rights reserved.
//

import Foundation

class UserWrapper {
    static let manager = UserWrapper()
    
    func getuserName() -> String {
        return (UserDefaults.standard.value(forKey: userNameKey) as? String) ?? ""
    }
    func getSwitch() -> Bool {
        return ((UserDefaults.standard.value(forKey: switchKey) != nil))
    }
    
    
    func store(userName: String) {
        UserDefaults.standard.set(userName, forKey: userNameKey)
    }
    func switchKey(switchBool: Bool) {
        UserDefaults.standard.set(switchBool, forKey: switchKey)
    }
    func backgroundKey(backgroundColor: Bool) {
        UserDefaults.standard.set(backgroundColor, forKey: backgroundColorKey)
    }
    
    
    private let backgroundColorKey = "backgroundColor"
    private let switchKey = "switchKey"
    private let userNameKey = "userName"
}
