//
//  SceneDelegate.swift
//  TutorialProject
//
//  Created by USER on 03/06/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScenen = (scene as? UIWindowScene) else { return }
        // khởi tạo windowScenen
        window = UIWindow(windowScene: windowScenen)
        
        // gán instance window vào biến window trong AppDelegate
        (UIApplication.shared.delegate as? AppDelegate)?.window = window
        /**
         kiểm tra xem User đã hoàn thành Tutorial hay chưa
         nếu chưa hoàn thành Tutorial thì sẽ Show màn hình Tutorial
         nếu đã hoàn thành Tutorial thì sẽ thực hiện code tiếp theo
         */
        let isCompletedTutorial = UserDefaultService.shared.completedTutorial
        if isCompletedTutorial {
            // kiểm tra xem User đã login hay chưa
            //yes-> chuyển đến màn hình main
            // no-> chuyển đến màn hình login
            
            let islogin = AuthService.share.isLoggedIn
            if islogin {
                gotoHome()
            } else {
                routeLogin()
            }
        } else {
            routeTutorial()
        }
    }
    private func routeTutorial() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tutorialVC = storyboard.instantiateViewController(withIdentifier: "TutoriallViewController")
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return}
        let nv = UINavigationController(rootViewController: tutorialVC)
        nv.setNavigationBarHidden(true, animated: true)
        window.rootViewController = nv
        window.makeKeyAndVisible()
    }
    private func routeLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginlVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return}
        let navi = UINavigationController(rootViewController: LoginlVC)
        navi.setNavigationBarHidden(true, animated: true)
        window.rootViewController = navi
        window.makeKeyAndVisible()
    }
    private func gotoHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gotoHomeVC = storyboard.instantiateViewController(withIdentifier: "MainTabbarViewController")
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return}
        let nav = UINavigationController(rootViewController: gotoHomeVC)
        nav.setNavigationBarHidden(true, animated: true)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
 
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

