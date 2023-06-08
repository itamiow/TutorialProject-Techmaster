//
//  RegisterViewController.swift
//  TutorialProject
//
//  Created by USER on 07/06/2023.
//

import UIKit

protocol RegisterDisplay {
    func validatefailure(message: String, type: ValidateTyPes)
    func showAlertView(message: String)
}


class RegisterViewController: UIViewController {
    
    @IBOutlet weak var myAvatarImage: UIImageView!
    @IBOutlet weak var regisTerLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var userNameTexField1: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passWordLabel: UILabel!
    
    @IBOutlet weak var regisTerButton: UIButton!
    
    var presenTer: RegisterPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authAPIService = AuthAPISerivceImpl()
        
        /**
         Khởi tại instance củaAuthRepository
         */
        let authRepository = AuthRepositoryImpl(authApiService: authAPIService)
        
        /**
         Khởi tại instance RegisterPresenter
         */
        presenTer = RegisterPresenterImpl(conTroller: self, authReposiTory: authRepository)
        
        setupUIRegister()
    }
    func setupUIRegister() {
        myAvatarImage.image = UIImage(named: "welcome")
        myAvatarImage.contentMode = .scaleAspectFill
        regisTerLabel.text = "Register"
        regisTerLabel.font = .boldSystemFont(ofSize: 30)
        nickNameTextField.placeholder = "Username: "
        userNameTexField1.placeholder = "Password: "
        passWordTextField.placeholder = "Passwordconfirmation: "
        nickNameTextField.keyboardType = .emailAddress
        
        regisTerButton.tintColor = .white
        regisTerButton.setTitle("Register", for: .normal)
        regisTerButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        regisTerButton.layer.cornerRadius = 10
        regisTerButton.backgroundColor = .systemCyan
        
        nickNameLabel.isHidden = true
        userNameLabel.isHidden = true
        passWordLabel.isHidden = true
    }
    @IBAction func nicknameClickTF(_ sender: UITextField) {
        nickNameLabel.isHidden = true
        userNameLabel.isHidden = true
        passWordLabel.isHidden = true
    }
    @IBAction func usernameClickTF(_ sender: UITextField) {
        nickNameLabel.isHidden = true
        userNameLabel.isHidden = true
        passWordLabel.isHidden = true
    }
    @IBAction func passwordClickTF(_ sender: UITextField) {
        nickNameLabel.isHidden = true
        userNameLabel.isHidden = true
        passWordLabel.isHidden = true
    }
    
  
    
    
    @IBAction func handleRegisterButton(_ sender: UIButton) {
        let username = userNameTexField1.text ?? ""
        let nickname = nickNameTextField.text ?? ""
        let password = passWordTextField.text ?? ""
        presenTer.register(username: username, nickname: nickname, password: password)
    }
    
    
    
    @IBAction func loginClick(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

enum ValidateTyPes {
    case nickname
    case username
    case password
}

extension RegisterViewController: RegisterDisplay {
  
    func validatefailure(message: String, type: ValidateTyPes) {
        switch type {
        case .username:
            userNameLabel.isHidden = false
            userNameLabel.text = message
            userNameLabel.textColor = .red
        case .nickname:
            nickNameLabel.isHidden = false
            nickNameLabel.text = message
            nickNameLabel.textColor = .red
        case .password:
            passWordLabel.isHidden = false
            passWordLabel.text = message
            passWordLabel.textColor = .red
        }
    }
        
    func showAlertView(message: String) {
        registerFailure(message: message)
    }
}
