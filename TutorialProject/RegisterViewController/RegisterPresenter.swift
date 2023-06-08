//
//  RegisterPresenter.swift
//  TutorialProject
//
//  Created by USER on 08/06/2023.
//

import Foundation
import UIKit
import ProgressHUD
protocol RegisterPresenter {
    func register(username: String, nickname: String, password: String)
}

class RegisterPresenterImpl: RegisterPresenter {
    var conTroller: RegisterDisplay
    var authReposiTory: AuthRepository
    
    init(conTroller: RegisterDisplay, authReposiTory: AuthRepository) {
        self.conTroller = conTroller
        self.authReposiTory = authReposiTory
    }
    
    func register(username: String, nickname: String, password: String) {
        ProgressHUD.fontStatus = .boldSystemFont(ofSize: 25)
        ProgressHUD.colorProgress = .systemBlue
        ProgressHUD.animationType = .lineSpinFade
        ProgressHUD.show()
        
        if username.isEmpty {
            conTroller.validatefailure(message: "Username is required", type: .username)
            ProgressHUD.dismiss()
            return
        }
        if username.count < 6 {
            conTroller.validatefailure(message: "Username must be at least 6 characters", type: .username)
            ProgressHUD.dismiss()
            return
        }
        if username.count > 40 {
            conTroller.validatefailure(message: "Username cannot be more than 40 characters", type: .username)
            ProgressHUD.dismiss()
            return
        }
        
        if username.contains(" ") == true {
            conTroller.validatefailure(message: "Username does not allow the use of space", type: .username)
            ProgressHUD.dismiss()
            return
        }
        
        if nickname.isEmpty {
            conTroller.validatefailure(message: "Email is required", type: .nickname)
            ProgressHUD.dismiss()
            return
        }
        if nickname.count < 4 {
            conTroller.validatefailure(message: "Email is required", type: .nickname)
            ProgressHUD.dismiss()
            return
        }
        if nickname.count > 40 {
            conTroller.validatefailure(message: "Email is required", type: .nickname)
            ProgressHUD.dismiss()
            return
        }
        if nickname.contains(" ") == true {
            conTroller.validatefailure(message: "Email is required", type: .nickname)
            ProgressHUD.dismiss()
            return
        }
        if password.isEmpty {
            conTroller.validatefailure(message: "Password is required", type: .password)
            ProgressHUD.dismiss()
            return
        }
        if password.count < 6 {
            conTroller.validatefailure(message: "Password must be at least 6 characters", type: .password)
            ProgressHUD.dismiss()
            return
        }
        if password.count > 40 {
            conTroller.validatefailure(message: "Password cannot be more than 40 characters", type: .password)
            ProgressHUD.dismiss()
            return
        }
        if password.contains(" ") == true {
            conTroller.validatefailure(message: "Password does not allow the use of space", type: .password)
            ProgressHUD.dismiss()
            return
        }
        
        authReposiTory.register(username: username, nickname: nickname, password: password) {response in  ProgressHUD.dismiss() }
      
    failure: {[weak self] errorMsg in
        guard let self = self else {return}
        ProgressHUD.dismiss()
        let message = "Registration failed"
        self.conTroller.showAlertView(message: message)
        return
    }
    }
}
extension UIViewController {
    func registerFailure(message: String) {
        let alert = UIAlertController(title: "Register Failure!", message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default) {_ in
            print("actionOK is Click")
        }
        alert.addAction(actionOK)
        self.present(alert, animated: true)
    }
}
