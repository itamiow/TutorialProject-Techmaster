//
//  TestLoginViewController.swift
//  TutorialProject
//
//  Created by USER on 09/06/2023.
//

import UIKit

class TestLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutClick(_ sender: UIButton) {
        
        AuthService.share.clearAll()
        routeLogin()
    }
    private func routeLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginlVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return}
        window.rootViewController = LoginlVC
        window.makeKeyAndVisible()
    }
}
