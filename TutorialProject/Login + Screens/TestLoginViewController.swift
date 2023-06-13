//
//  TestLoginViewController.swift
//  TutorialProject
//
//  Created by USER on 09/06/2023.
//

import UIKit

class TestLoginViewController: UIViewController {
    
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutButton.layer.cornerRadius = 10
    }
    
    
    @IBAction func logoutClick(_ sender: UIButton) {
        
        AuthService.share.clearAll()
//        UserDefaultService.shared.clearAll()
        routeLogin()
    }
    private func routeLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginlVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return}
        let navi = UINavigationController(rootViewController: LoginlVC)
        navi.setNavigationBarHidden(true, animated: true)
        window.rootViewController = navi
        window.makeKeyAndVisible()
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func nextTabbarClick(_ sender: UIButton) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemPink
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
