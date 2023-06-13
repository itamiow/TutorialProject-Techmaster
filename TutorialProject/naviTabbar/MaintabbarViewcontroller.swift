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
        UITabBar.appearance().backgroundColor = UIColor.white
//        UITabBar.appearance().tintColor = .clear
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage()
        setViewControllers([homeVC,settings,highlighter,comment,pinblack], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    /**
     lazy chỉ khởi tạo 1 lần khi mã gọi đầu tiên
     */
    lazy var homeVC: UIViewController =  {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestLoginViewController")
        viewController.view.backgroundColor = .white
        viewController.tabBarItem = ESTabBarItem(CustomStyleTabBarContentView(),
                                                 title: "home".uppercased(),
                                                 // defined 2 ảnh
                                                 // 1 icon là khi chưa chọn
                                                 // 1 icon là khi đã chọn
                                                 image: UIImage(named: "home"),
                                                 selectedImage: UIImage(named: "home"))
        let nav = UINavigationController(rootViewController: viewController)
        nav.setNavigationBarHidden(true, animated: true)
        return nav
    } ()
    
    lazy var settings: UIViewController =  {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestLoginViewController")
        viewController.view.backgroundColor = .systemBlue
        viewController.tabBarItem = ESTabBarItem(CustomStyleTabBarContentView(),
                                                 title: "settings".uppercased(),
                                                 image: UIImage(named: "settings"),
                                                 selectedImage: UIImage(named: "settings"))
        let nav = UINavigationController(rootViewController: viewController)
        nav.setNavigationBarHidden(true, animated: true)
        return nav } ()
    
    lazy var highlighter: UIViewController =  {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestLoginViewController")
        viewController.view.backgroundColor = .systemTeal
        viewController.tabBarItem = ESTabBarItem(CustomStyleTabBarContentView(),
                                                 title: "highlighter".uppercased(),
                                                 image: UIImage(named: "highlighter"),
                                                 selectedImage: UIImage(named: "highlighter"))
        let nav = UINavigationController(rootViewController: viewController)
        nav.setNavigationBarHidden(true, animated: true)
        return nav } ()
    
    lazy var comment: UIViewController =  {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestLoginViewController")
        viewController.view.backgroundColor = .systemPink
        viewController.tabBarItem = ESTabBarItem(CustomStyleTabBarContentView(),
                                                 title: "comment".uppercased(),
                                                 image: UIImage(named: "comment"),
                                                 selectedImage: UIImage(named: "comment"))
        let nav = UINavigationController(rootViewController: viewController)
        nav.setNavigationBarHidden(true, animated: true)
        return nav } ()
    
    lazy var pinblack: UIViewController =  {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestLoginViewController")
        viewController.view.backgroundColor = .systemGray
        viewController.tabBarItem = ESTabBarItem(CustomStyleTabBarContentView(),
                                                 title: "pinblack".uppercased(),
                                                 image: UIImage(named: "pinblack"),
                                                 selectedImage: UIImage(named: "pinblack"))
        let nav = UINavigationController(rootViewController: viewController)
        nav.setNavigationBarHidden(true, animated: true)
        return nav } ()
}
