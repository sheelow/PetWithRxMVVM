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

        let tableViewNavigationController = UINavigationController(rootViewController: TableViewController(tableViewModel: TableViewModel(service: NetworkService())))
        let collectionViewNavigationController = UINavigationController(rootViewController: CollectionViewController())
        let galleryViewNavigationController = UINavigationController(rootViewController: GalleryViewController())
        let pageViewNavigationController = UINavigationController(rootViewController: PageViewController())
        let profileViewNavigationController = UINavigationController(rootViewController: ProfileViewController())

        tableViewNavigationController.tabBarItem = UITabBarItem(
            title: "Table Мемы",
            image: UIImage(systemName: "tablecells"),
            tag: 0)
        collectionViewNavigationController.tabBarItem = UITabBarItem(
            title: "Collection Мемы",
            image: UIImage(systemName: "pip"),
            tag: 1)
        galleryViewNavigationController.tabBarItem = UITabBarItem(
            title: "Gallery Мемы",
            image: UIImage(systemName: "display"),
            tag: 2)
        pageViewNavigationController.tabBarItem = UITabBarItem(
            title: "Page Мемы",
            image: UIImage(systemName: "list.bullet.rectangle"),
            tag: 3)
        profileViewNavigationController.tabBarItem = UITabBarItem(
            title: "Мой профиль",
            image: UIImage(systemName: "person"),
            tag: 4)

        viewControllers = [tableViewNavigationController, collectionViewNavigationController, galleryViewNavigationController, pageViewNavigationController, profileViewNavigationController]

        tabBar.backgroundColor = .white
    }
}
