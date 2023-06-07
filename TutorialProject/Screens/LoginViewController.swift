//
//  LoginViewController.swift
//  TutorialProject
//
//  Created by USER on 05/06/2023.
//

import UIKit

protocol LoginDisplay {
    func validateFailure(message: String)
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
 
    
    @IBAction func registerClick(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let inputNext = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        inputNext.modalPresentationStyle = .fullScreen
        self.present(inputNext, animated: true)
    }
}



extension LoginViewController: LoginDisplay {

    func validateFailure(message: String) {
        print(message)
        
    }
    
    
}
