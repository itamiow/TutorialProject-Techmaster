//
//  RegisterPresenter.swift
//  TutorialProject
//
//  Created by USER on 08/06/2023.
//

import Foundation
import UIKit
import MBProgressHUD

protocol RegisterPresenter {
    func register(username: String, nickname: String, password: String)
}

class RegisterPresenterImpl: RegisterPresenter{
    
    var registerVC: RegisterDisplay
    var authRepository: AuthRepository
    
    init(registerVC: RegisterDisplay, authRepository: AuthRepository) {
        self.registerVC = registerVC
        self.authRepository = authRepository
    }
    
    private func registerValidateFrom(username: String, nickname: String, password: String) -> Bool{
        var isvalid = true
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        if username.isEmpty {
            isvalid = false
            registerVC.validatefailure(message: "Username is required", type: .username)
        } else if username.count < 4 {
            isvalid = false
            registerVC.validatefailure(message: "Username must be at least 4 characters", type: .username)
        } else if username.count > 40 {
            isvalid = false
            registerVC.validatefailure(message: "Username can't be longer than 40 characters", type: .username)
        } 
        
        if nickname.isEmpty {
            isvalid = false
            registerVC.validatefailure(message: "Email is required", type: .nickname)
        } else if nickname.count < 4 {
            isvalid = false
            registerVC.validatefailure(message: "Email must be at least 4 characters", type: .nickname)
        } else if nickname.count > 40 {
            isvalid = false
            registerVC.validatefailure(message: "Email can't be longer than 40 characters", type: .nickname)
        } else if !emailPredicate.evaluate(with: nickname) {
                isvalid = false
                registerVC.validatefailure(message: "Invalid email format", type: .nickname)
            }
    
        if password.isEmpty {
            isvalid = false
            registerVC.validatefailure(message: "Password is required", type: .password)
        } else if password.count < 4 {
            isvalid = false
            registerVC.validatefailure(message: "Password must be at least 4 characters", type: .password)
        } else if password.count > 40 {
            isvalid = false
            registerVC.validatefailure(message: "Password can't be longer than 40 characters", type: .password)
        }
        return isvalid
    }

    func register(username: String, nickname: String, password: String) {
        let isValid = registerValidateFrom(username: username, nickname: nickname, password: password)
        
        guard isValid else {return}
        
        registerVC.showLoading(isProgress: true)
        authRepository.register(username: username, nickname: nickname, password: password) { [weak self] registerEntity in
            guard let self = self else {return}
            self.registerVC.showLoading(isProgress: false)
            if let accessToken = registerEntity.accessToken, !accessToken.isEmpty {
                AuthService.share.accessToken = accessToken
//                self.registerVC.registersucces()
                // đăng kí thành công thì showAlert
                self.registerVC.showAlertSuccess()
            } else {
                self.registerVC.registerFailure(errorMsg: "Something went wrong!")
            }
            
        } failure: { [weak self] apiError in
            guard let self = self else {return}
            self.registerVC.showLoading(isProgress: false)
            self.registerVC.registerFailure(errorMsg: apiError ?? "Something went wrong!")
        }
    }
}
