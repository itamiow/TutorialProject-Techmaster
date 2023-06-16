//
//  MainDefaultUITabbarController.swift
//  TutorialProject
//
//  Created by USER on 14/06/2023.
//

import Foundation
import UIKit

class MainDefaultUITabbarController: UITabBarController {
    
    var arrayOfImageNameForSelected = ["home","settings", "highlighted","comment", "pinblack"]
    var arrayOfImageNameForUnSelected = ["home","settings", "highlighted","comment", "pinblack"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemPink
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelected = arrayOfImageNameForSelected[i]
                let imageNameForUnSelected = arrayOfImageNameForUnSelected[i]
                let image = UIImage(named: imageNameForSelected)?.withRenderingMode(.alwaysTemplate)
                self.tabBar.items?[i].selectedImage = image
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnSelected)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].imageInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            }
        }
        
        let selecColor = UIColor.red
        let unselecColor = UIColor.black
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: unselecColor ], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: selecColor], for: .normal)
        
    }
}


