//
//  TabsViewController.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 30/11/2021.
//

import UIKit

class TabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }

    private func createTabBar() {
        
        let activityNavigationController = UINavigationController(rootViewController: ActivityDetailsViewController())
        let profileNavigationController = UINavigationController(rootViewController: ProfileViewController())
        
        activityNavigationController.tabBarItem.title = "Активности"
        activityNavigationController.tabBarItem.image = UIImage(systemName: "circle")
        
        profileNavigationController.tabBarItem.title = "Профиль"
        profileNavigationController.tabBarItem.image = UIImage(systemName: "circle")
        
        self.setViewControllers([activityNavigationController, profileNavigationController], animated: true)
        
        modalPresentationStyle = .overFullScreen
    }
}
