//
//  LoginPresenter.swift
//  TutorialProject
//
//  Created by USER on 05/06/2023.
//

import Foundation
import UIKit

/**
 Xử lý business logic
 */

protocol LoginPresenter {
    func login(username: String, password: String)
}

/**
 Implement
 */
class LoginPresenterImpl: LoginPresenter {
    var controller: LoginDisplay
    var authRepository: AuthRepository
    
    init(controller: LoginDisplay, authRepository: AuthRepository) {
        self.controller = controller
        self.authRepository = authRepository
    }
    
//    func validateForm() -> Bool {
//        return false
//    }
    
    func login(username: String, password: String) {
        /// Check validate username
        if username.isEmpty {
            controller.validateFailure(message: "Username is required")
        } else {
            
            // Show loading
            authRepository.login(username: username, password: password) { response in
                ///
                /// tắt loading
                /// Kiểm tra xem trong response đã có data chưa
                ///
            } failure: { errorMsg in
                /// tắt loading
                /// Trả về message lỗi cho viewcontroller
            }

        }
    }
}
