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
        let authAPIService = AuthAPIServiceImpl()
//        let authPepository = AuthAPIServiceImpl(authAPIService: authAPIService)
//        presenter = LoginPresenterImpl(controller: self,authRepository: authPepository)
        
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
    
}

extension LoginViewController: LoginDisplay {
 
    
    func validateFailure(message: String) {
        print(message)
        
    }
    
    
}
