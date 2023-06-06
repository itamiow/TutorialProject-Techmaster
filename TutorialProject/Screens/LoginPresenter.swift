//
//  LoginPresenter.swift
//  TutorialProject
//
//  Created by USER on 05/06/2023.
//

import Foundation
import UIKit

// xử lý business logic

protocol LoginPresenter {
    func login(username: String, password: String)
    }
class LoginPresenterImpl: LoginPresenter {
    var controller: LoginDisplay
    var authRepository: AuthRepository
    init(controller: LoginDisplay, authRepository: AuthRepository) {
        self.controller = controller
        self.authRepository = authRepository
    }
//    func validateFrom() -> Bool {
//        return false
//    }
        func login(username: String, password: String) {
            // cjecl validate username
            if username.isEmpty {
                controller.validateFailure(message: "Username is required")
            } else {
                authRepository.login(username: username, password: password) {response in
                    // tắt loading
                    // kiểm tra xem trong response đã có data chưa
                } failure: { errorMsg in }
                // tắt loadding
                // trả về message lỗi cho viewcontroller
            }
        }
    
}
