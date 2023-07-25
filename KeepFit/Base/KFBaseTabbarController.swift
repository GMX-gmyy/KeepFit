//
//  BaseTabbarController.swift
//  KeepFit
//
//  Created by 龚梦洋 on 2023/7/25.
//

import Foundation
import UIKit

class KFBaseTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatChildViewControllers()
    }
    
    private func creatChildViewControllers() {
        let vc1 = KFHomeViewController()
        vc1.tabBarItem.image = UIImage(named: "homeSelect")?.withRenderingMode(.alwaysOriginal)
        vc1.tabBarItem.selectedImage = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        let navi1 = KFBaseNavigationController(rootViewController: vc1)
        
        let vc2 = KFRecordViewController()
        vc2.tabBarItem.image = UIImage(named: "record")?.withRenderingMode(.alwaysOriginal)
        vc2.tabBarItem.selectedImage = UIImage(named: "recordSelect")?.withRenderingMode(.alwaysOriginal)
        let navi2 = KFBaseNavigationController(rootViewController: vc2)
        
        let vc3 = KFShowViewController()
        vc3.tabBarItem.image = UIImage(named: "show")?.withRenderingMode(.alwaysOriginal)
        vc3.tabBarItem.selectedImage = UIImage(named: "showSelect")?.withRenderingMode(.alwaysOriginal)
        let navi3 = KFBaseNavigationController(rootViewController: vc3)
        
        viewControllers = [navi1, navi2, navi3]
    }
}
