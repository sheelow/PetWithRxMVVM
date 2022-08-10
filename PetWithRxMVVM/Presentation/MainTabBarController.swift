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
        let galleryViewNavigationController = UINavigationController(rootViewController: GalleryViewController())
        let pageViewNavigationController = UINavigationController(rootViewController: PageViewController())
        let profileViewNavigationController = UINavigationController(rootViewController: ProfileViewController())

        tableViewNavigationController.tabBarItem = UITabBarItem(
            title: "Table",
            image: UIImage(systemName: "tablecells"),
            tag: 0)
        collectionViewNavigationController.tabBarItem = UITabBarItem(
            title: "Collection",
            image: UIImage(systemName: "pip"),
            tag: 1)
        galleryViewNavigationController.tabBarItem = UITabBarItem(
            title: "Gallery",
            image: UIImage(systemName: "display"),
            tag: 2)
        pageViewNavigationController.tabBarItem = UITabBarItem(
            title: "Page",
            image: UIImage(systemName: "list.bullet.rectangle"),
            tag: 3)
        profileViewNavigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 4)
        

        viewControllers = [tableViewNavigationController, collectionViewNavigationController, galleryViewNavigationController, pageViewNavigationController, profileViewNavigationController]

        tabBar.backgroundColor = .white
    }
}
