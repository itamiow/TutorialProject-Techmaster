//
//  LoginPresenter.swift
//  NewfeedsApp
//
//  Created by Minh Tan Vu on 05/06/2023.
//

import Foundation
import MBProgressHUD
/**
 Xử lý bussiness login
 */

protocol LoginPresenter {
    func login(username: String, password: String)
}

class LoginPresenterImpl: LoginPresenter {
    
    var loginVC: LoginDisplay
    var authRepository: AuthRepository
    
    init(loginVC: LoginDisplay, authRepository: AuthRepository) {
        self.loginVC = loginVC
        self.authRepository = authRepository
    }
    
    private func loginvalidateForm(username: String, password: String) -> Bool {
        var isValid = true
        
        //Check validate username
        if username.isEmpty {
            isValid = false
            loginVC.validateFailure(message: "Username is required", type: .userName)
        } else if username.count < 4 {
            
            isValid = false
            loginVC.validateFailure(message: "Username must be at least 4 characters", type: .userName)
        } else if username.count > 40 {
            isValid = false
            loginVC.validateFailure(message: "Username can't be longer than 40 characters", type: .userName)
        }
        //Check validate password
        if password.isEmpty {
            isValid = false
            loginVC.validateFailure(message: "Password is required", type: .password)
        } else if password.count < 6 {
            isValid = false
            loginVC.validateFailure(message: "Password must be at least 6 characters", type: .password)
        } else if password.count > 40 {
            isValid = false
            loginVC.validateFailure(message: "Password can't be longer than 40 characters", type: .password)
        }
        return isValid
    }
    
    func login(username: String, password: String) {
        let isValid = loginvalidateForm(username: username, password: password)
        guard isValid else {return}
        loginVC.showloading(isShow: true)
        authRepository.login(username: username, password: password) {[weak self] loginEntity in
            guard let self = self else {return}
            self.loginVC.showloading(isShow: false)
            if let accessToken = loginEntity.accessToken, !accessToken.isEmpty {
                AuthService.share.accessToken = accessToken
                self.loginVC.loginSuccess()
            } else {
                self.loginVC.loginFailure(errorMsg: "Something went wrong!")
            }
            
        } failure: { [weak self] apiError in
            guard let self = self else {return}
            self.loginVC.showloading(isShow: false)
            self.loginVC.loginFailure(errorMsg: apiError ?? "Something went wrong!")
        }
    }
}
