//
//  MainTabBarController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 08.08.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }

    private func configureTabBar() {

        let tableViewNavigationController = UINavigationController(rootViewController: TableViewController())
        let collectionViewNavigationController = UINavigationController(rootViewController: CollectionViewController())

        tableViewNavigationController.tabBarItem = UITabBarItem(
            title: "Table",
            image: UIImage(systemName: "list.bullet.rectangle"),
            tag: 0)
        collectionViewNavigationController.tabBarItem = UITabBarItem(
            title: "Collection",
            image: UIImage(systemName: "star"),
            tag: 1)

        viewControllers = [tableViewNavigationController, collectionViewNavigationController]

        tabBar.backgroundColor = .white
    }
}

