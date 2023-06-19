//
//  RegisterViewController.swift
//  TutorialProject
//
//  Created by USER on 07/06/2023.
//

import UIKit
import MBProgressHUD

protocol RegisterDisplay {
    func registersucces()
    func showLoading(isProgress: Bool)
    func validatefailure(message: String, type: ValidateTyPes)
    func registerFailure(errorMsg: String?)
    func showAlertSuccess()
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
    
    var presenter: RegisterPresenter!
    
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
        presenter = RegisterPresenterImpl(registerVC: self, authRepository: authRepository)
        setupUIRegister()
    }
    func setupUIRegister() {
        regisTerLabel.text = "Register"
        regisTerLabel.font = .boldSystemFont(ofSize: 30)
//        userNameTexField1.placeholder = "Username: "
//        nickNameTextField.placeholder = "Email: "
//        passWordTextField.placeholder = "Password: "
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
    @IBAction func handleRegisterButton(_ sender: UIButton) {
       
        let username = userNameTexField1.text ?? ""
        let nickname = nickNameTextField.text ?? ""
        let password = passWordTextField.text ?? ""
        presenter.register(username: username, nickname: nickname, password: password)
    }
    @IBAction func loginClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

enum ValidateTyPes {
    case nickname
    case username
    case password
}
extension RegisterViewController: RegisterDisplay {
    func showAlertSuccess() {
        let showAlert = UIAlertController(title: "Notification!", message: "Register Success", preferredStyle: .alert)
        showAlert.addAction(UIAlertAction(title: "OK", style: .default) {_ in
            // chuyen man
            self.registerCLick()
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let nextRegisterVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
//            guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return}
//            window.rootViewController = nextRegisterVC
//            window.makeKeyAndVisible()
        })
        self.present(showAlert, animated: true)
    }
    
    func registersucces() {
       registerCLick()
    }

    func registerFailure(errorMsg: String?) {
        let showAlert = UIAlertController(title: "Register Failure", message: errorMsg, preferredStyle: .alert)
        showAlert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(showAlert, animated: true)
    }
    
    func showLoading(isProgress: Bool) {
        if isProgress {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        } else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
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
}
extension RegisterViewController {
    private func registerCLick() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gotoLoginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return}
        window.rootViewController = gotoLoginVC
        window.makeKeyAndVisible()
    }
}
