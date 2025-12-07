//
//  UserTabBarViewController.swift
//  throw
//
//  Created by Nitya Baddam on 11/16/25.
//

import UIKit

class UserTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
    
    func configureTabs() {
        let vc1 = FeedViewController()
        let vc2 = CreatePostViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "plus")
        
        vc1.title = "Feed"
        vc2.title = "Create"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        setViewControllers([nav1, nav2], animated: true)
    }

}

