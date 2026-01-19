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
        let vc1 = FeedViewController(dataSource: SessionsDataSource())
        let vc2 = CreatePostViewController()

        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.title = "Feed" // adds label to tab bar item and adds accessibility label

        vc2.tabBarItem.image = UIImage(systemName: "plus")
        vc2.title = "Create" // not as reliable with adding visual label as tabBarItem.title
        vc2.tabBarItem.accessibilityLabel = "Create"

        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)

        setViewControllers([nav1, nav2], animated: true)
    }

}

