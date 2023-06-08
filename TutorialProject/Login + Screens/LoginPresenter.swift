//
//  LoginPresenter.swift
//  TutorialProject
//
//  Created by USER on 05/06/2023.
//

import Foundation
import UIKit
import ProgressHUD
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
        ProgressHUD.fontStatus = .boldSystemFont(ofSize: 25)
        ProgressHUD.colorProgress = .systemBlue
        ProgressHUD.animationType = .lineSpinFade
        ProgressHUD.show()
        /// Check validate username
        if username.isEmpty {
            controller.validateFailure(message: "Username is required", type: .userName)
            ProgressHUD.dismiss()
            return
        }
        if username.count < 6 {
            controller.validateFailure(message: "Username must be at least 6 characters", type: .userName)
            ProgressHUD.dismiss()
            return
        }
        
        if username.count > 40 {
            controller.validateFailure(message: "Username cannot be more than 40 characters", type: .userName)
            ProgressHUD.dismiss()
            return
        }
        if username.contains(" ") == true {
            controller.validateFailure(message: "Username does not allow the use of space", type: .userName)
            ProgressHUD.dismiss()
            return
        }
        
        if password.isEmpty {
            controller.validateFailure(message: "Password is required", type: .password)
            ProgressHUD.dismiss()
            return
        }
        if password.count < 6 {
            controller.validateFailure(message: "Password must be at least 6 characters", type: .password)
            ProgressHUD.dismiss()
            return
        }
        if password.count > 40 {
            controller.validateFailure(message: "Password cannot be more than 40 characters", type: .password)
            ProgressHUD.dismiss()
            return
        }
        if password.contains(" ") == true {
            controller.validateFailure(message: "Password does not allow the use of space", type: .password)
            ProgressHUD.dismiss()
            return
        }
        
        authRepository.login(username: username, password: password) { response in
            ProgressHUD.dismiss()
        } failure: {[weak self] errorMsg in
            guard let self = self else {return}
            ProgressHUD.dismiss()
            let message = "Login information is incorrect"
            self.controller.showAlert(message: message)
            return
        }
    }
}
extension UIViewController {
    func loginFailure(message: String) {
        let alert = UIAlertController(title: "Login Failure!", message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default) {_ in
            print("actionOK is Click")
        }
        alert.addAction(actionOK)
        self.present(alert, animated: true)
    }
}
