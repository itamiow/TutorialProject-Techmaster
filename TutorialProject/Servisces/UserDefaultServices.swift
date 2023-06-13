//
//  UserDefaultServices.swift
//  TutorialProject
//
//  Created by USER on 09/06/2023.
//

import Foundation



class UserDefaultService {
    
    // khởi tạo 1 instance của class
    static var shared = UserDefaultService()
    private var standard = UserDefaults.standard
    
    private enum Keys: String {
        case kCompletedTutotial
    }
    
    
    // ngăn không cho khởi tạo isnstance thứ 2 của class
    
    private init() {
        
    }

    var completedTutorial: Bool {
        // Get là khi lấy ra giá trị của biến bằng UserDefaultService.shared.completedTutorial
        get {
            return standard.bool(forKey: Keys.kCompletedTutotial.rawValue)
//            return standard.bool(forKey: "kCompletedTutotial")
        }
// hàm set được chạy vào khi gán giá trị vào cho biến UserDefaultService.shared.completedTutorial = true
        set {
            standard.set(newValue, forKey: Keys.kCompletedTutotial.rawValue)
            standard.synchronize()
        }
    }
    func clearAll() {
        standard.removeObject(forKey: Keys.kCompletedTutotial.rawValue)
    }
    
}
