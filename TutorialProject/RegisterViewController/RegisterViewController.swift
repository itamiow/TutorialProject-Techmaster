//
//  RegisterViewController.swift
//  TutorialProject
//
//  Created by USER on 07/06/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var myAvatarImage: UIImageView!
    @IBOutlet weak var regisTerLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameTexField1: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    
    
    @IBOutlet weak var regisTerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIRegister()
        // Do any additional setup after loading the view.
    }
    func setupUIRegister() {
        myAvatarImage.image = UIImage(named: "welcome")
        myAvatarImage.contentMode = .scaleAspectFill
        regisTerLabel.text = "Register"
        regisTerLabel.font = .boldSystemFont(ofSize: 30)
        userNameTextField.placeholder = "Username: "
        userNameTexField1.placeholder = "Username: "
        passWordTextField.placeholder = "Password"
        
        regisTerButton.tintColor = .white
        regisTerButton.setTitle("Register", for: .normal)
        regisTerButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        regisTerButton.layer.cornerRadius = 10
        regisTerButton.backgroundColor = .systemCyan
    }
    
    
    @IBAction func loginClick(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
