//
//  LoginViewController.swift
//  TutorialProject
//
//  Created by USER on 05/06/2023.
//

import UIKit
import ProgressHUD

protocol LoginDisplay {
    func validateFailure(message: String, type: ValidateType)
    func showAlert(message: String)
}


class LoginViewController: UIViewController {
    
    @IBOutlet weak var avaTarImage: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var myLabel1: UILabel!
    @IBOutlet weak var myLabel2: UILabel!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        /**
         Khởi tại instance của AuthAPISerivce
         */
        let authAPIService = AuthAPISerivceImpl()
        
        /**
         Khởi tại instance củaAuthRepository
         */
        let authRepository = AuthRepositoryImpl(authApiService: authAPIService)
        
        /**
         Khởi tại instance LoginPresenter
         */
        presenter = LoginPresenterImpl(controller: self, authRepository: authRepository)
        
        
        setupUI()
        super.viewDidLoad()
      
    }
    func setupUI(){
        avaTarImage.image = UIImage(named: "welcome")
        avaTarImage.contentMode = .scaleAspectFill
        loginLabel.text = "Login"
        loginLabel.font = .boldSystemFont(ofSize: 30)
        myLabel1.isHidden = true
        myLabel2.isHidden = true
        usernameTF.placeholder = "Username: "
        password.placeholder = "Password: "
        password.isSecureTextEntry = true
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        loginButton.backgroundColor = .systemCyan
        loginButton.layer.cornerRadius = 10
        loginButton.tintColor = .white
    }

    @IBAction func handleLoginTap(sender: UIButton) {
        let username = usernameTF.text ?? ""
        let password = password.text ?? ""
        presenter.login(username: username, password: password)
        
    }
 
    @IBAction func usernameTextFieldClick(_ sender: UITextField) {
        myLabel1.isHidden = true
        myLabel2.isHidden = true
    }
    @IBAction func PasswordTextFieldClick(_ sender: UITextField) {
        myLabel2.isHidden = true
        myLabel2.isHidden = true
    }
    
    
    
    
    @IBAction func registerClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let inputNext = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        inputNext.modalPresentationStyle = .fullScreen
        self.present(inputNext, animated: true)
    }
}


enum ValidateType {
    case userName
    case password
}

extension LoginViewController: LoginDisplay {
    func validateFailure(message: String, type: ValidateType) {
        switch type {
        case .userName:
            myLabel1.isHidden = false
            myLabel1.text = message
            myLabel1.textColor = .red
        case .password:
            myLabel2.isHidden = false
            myLabel2.text = message
            myLabel2.textColor = .red
        }
    }
    
    func showAlert(message: String) {
        loginFailure(message: message)
    }
}
