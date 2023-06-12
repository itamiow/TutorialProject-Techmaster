//
//  MaintabbarViewcontroller.swift
//  TutorialProject
//
//  Created by USER on 12/06/2023.
//

import Foundation
import ESTabBarController_swift
class MainTabbarViewController: ESTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([homeVC,homeVC,homeVC], animated: true)
    }
    
    
    /**
     lazy chi khoi tao 1 lan khi ma goi dau tien
     */
    lazy var homeVC: UIViewController =  {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestLoginViewController")
        viewController.tabBarItem = ESTabBarItem(CustomStyleTabBarContentView(),
                                                 title: "Home".uppercased(),
                                                 // defined 2 anh
                                                 // 1 icon la khi chua chon
                                                 // 1 icon la khi da chon
                                                 image: UIImage(named: "Home"),
                                                 selectedImage: UIImage(named: "Home"))
        let nav = UINavigationController(rootViewController: viewController)
        nav.setNavigationBarHidden(true, animated: true)
        return nav
    } ()
    
    
    lazy var settings: UIViewController =  {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestLoginViewController")
        viewController.tabBarItem = ESTabBarItem(CustomStyleTabBarContentView(),
                                                 title: "settings".uppercased(),
                                                 // defined 2 anh
                                                 // 1 icon la khi chua chon
                                                 // 1 icon la khi da chon
                                                 image: UIImage(named: "settings"),
                                                 selectedImage: UIImage(named: "settings"))
        let nav = UINavigationController(rootViewController: viewController)
        nav.setNavigationBarHidden(true, animated: true)
        return nav } ()
}
