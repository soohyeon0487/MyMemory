//
//  UserInfoManager.swift
//  MyMemory
//
//  Created by Soohyeon Lee on 2021/01/13.
//

import UIKit

struct UserInfoKey {
    static let loginId = "LOGINID"
    static let account = "ACCOUNT"
    static let name = "NAME"
    static let profile = "PROFILE"
    static let tutorial = "TUTORIAL"
}

class UserInfoManager {
    
    var loginId: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.loginId)
        }
        set(input) {
            let ud = UserDefaults.standard
            ud.setValue(input, forKey: UserInfoKey.loginId)
            ud.synchronize()
        }
    }
    
    var account: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.account)
        }
        set(input) {
            let ud = UserDefaults.standard
            ud.setValue(input, forKey: UserInfoKey.account)
            ud.synchronize()
        }
    }
    
    var name: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.name)
        }
        set(input) {
            let ud = UserDefaults.standard
            ud.setValue(input, forKey: UserInfoKey.name)
            ud.synchronize()
        }
    }
    
    var profile: UIImage? {
        get {
            let ud = UserDefaults.standard
            if let _profile = ud.data(forKey: UserInfoKey.profile) {
                return UIImage(data: _profile)
            }
            return UIImage(systemName: "person.fill")
        }
        set(input) {
            if input != nil {
                let ud = UserDefaults.standard
                ud.setValue(input!.pngData(), forKey: UserInfoKey.profile)
                ud.synchronize()
            }
        }
    }
    
    var isLogin: Bool {
        if self.loginId == 0 || self.account == nil {
            return false
        } else {
            return true
        }
    }
    
    func login(account: String, passwd:String) -> Bool {
        
        if (account == "sqlpro@naver.com") && (passwd == "1234") {
            
            let ud = UserDefaults.standard
            ud.setValue(100, forKey: UserInfoKey.loginId)
            ud.setValue(account, forKey: UserInfoKey.account)
            ud.setValue("재은 씨", forKey: UserInfoKey.name)
            ud.synchronize()
            return true
        } else {
            return false
        }
    }
    
    func logout() -> Bool {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: UserInfoKey.loginId)
        ud.removeObject(forKey: UserInfoKey.account)
        ud.removeObject(forKey: UserInfoKey.name)
        ud.removeObject(forKey: UserInfoKey.profile)
        ud.synchronize()
        return true
    }
}
