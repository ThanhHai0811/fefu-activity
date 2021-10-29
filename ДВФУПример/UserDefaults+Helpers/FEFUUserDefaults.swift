//
//  FEFUUserDefaults.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 24/10/2021.
//

import Foundation

class FEFUUsersDefaults {
    static let shared = FEFUUsersDefaults()
    private let defaults = UserDefaults.standard
    private let userNameKey = "username"
    private init(){}
    func saveUserName(userName: String){
        defaults.setValue(userName, forKey: userNameKey)
    }
    func getUserName() -> String? {
        return defaults.string(forKey: userNameKey)
    }
}
