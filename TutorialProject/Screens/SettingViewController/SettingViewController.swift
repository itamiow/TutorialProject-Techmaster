//
//  SettingViewController.swift
//  TutorialProject
//
//  Created by USER on 15/06/2023.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var emtyView: UIView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    
        //call api tra ve success { list in
        // if list.isEmpty {
        // emtyView.isHidden = false
        //} else {
       // emtyView.isHidden = true
        //}
        //}, fail {
        //emtyView.isHidden = false
  ///  }
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func Logout(_ sender: UIButton) {
        AuthService.share.clearAll()
        UserDefaultService.shared.clearAll()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return}
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: true)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        
        
    }
}
