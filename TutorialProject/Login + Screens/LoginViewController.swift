//
//  LoginViewController.swift
//  TutorialProject
//
//  Created by USER on 05/06/2023.
//

import UIKit
import MBProgressHUD

protocol LoginDisplay {
    func loginSuccess()
    func validateFailure(message: String, type: ValidateType)
    func showloading(isShow: Bool)
    func loginFailure(errorMsg: String?)
    
}


class LoginViewController: UIViewController {
    
    @IBOutlet weak var avaTarImage: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
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
        presenter = LoginPresenterImpl(loginVC: self, authRepository: authRepository)
        
        
        setupUI()
        super.viewDidLoad()
        
    }
    func setupUI(){
        loginLabel.font = .boldSystemFont(ofSize: 30)
        usernameLabel.isHidden = true
        passwordLabel.isHidden = true
        password.isSecureTextEntry = true
        
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        loginButton.backgroundColor = .systemCyan
        loginButton.layer.cornerRadius = 10
        loginButton.tintColor = .white
    }
    
    @IBAction func handleLoginTap(sender: UIButton) {
        //        usernameLabel.isHidden = false
        //        passwordLabel.isHidden = false
        let username = usernameTF.text ?? ""
        let password = password.text ?? ""
        presenter.login(username: username, password: password)
        
    }
    
    @IBAction func usernameTextFieldClick(_ sender: UITextField) {
        usernameLabel.isHidden = true
    }
    @IBAction func PasswordTextFieldClick(_ sender: UITextField) {
        passwordLabel.isHidden = true
    }
    @IBAction func registerClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let inputNext = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        //        inputNext.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(inputNext, animated: true)
    }
}
enum ValidateType {
    case userName
    case password
}

extension LoginViewController: LoginDisplay {
    func loginSuccess() {
        nextLogin()
    }
    
    func loginFailure(errorMsg: String?) {
        let showAlert = UIAlertController(title: "Login Failure", message: errorMsg, preferredStyle: .alert)
        showAlert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(showAlert, animated: true)
    }
    
    func showloading(isShow: Bool) {
        if isShow {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        } else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    func validateFailure(message: String, type: ValidateType) {
        switch type {
        case .userName:
            usernameLabel.isHidden = false
            usernameLabel.text = message
            usernameLabel.textColor = .red
        case .password:
            passwordLabel.isHidden = false
            passwordLabel.text = message
            passwordLabel.textColor = .red
        }
    }
}
extension LoginViewController {
    private func nextLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextLoginlVC = storyboard.instantiateViewController(withIdentifier: "MainTabbarViewController")
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return}
        let nav = UINavigationController(rootViewController: nextLoginlVC)
        nav.setNavigationBarHidden(true, animated: true)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
