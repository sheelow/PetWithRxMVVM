//
//  ViewController + CustomBarButtonItem.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 09.08.2022.
//

import UIKit

extension UIViewController {

    func createCustomLogoutButton(selector: Selector) -> UIBarButtonItem {
        let customLogoutButton = UIButton(type: .system)
        customLogoutButton.setImage(UIImage(systemName: "arrow.uturn.down.square"), for: .normal)
        customLogoutButton.setTitle("Logout", for: .normal)
        customLogoutButton.addTarget(self, action: selector, for: .touchUpInside)

        let menuCustomLogoutItem = UIBarButtonItem(customView: customLogoutButton)
        return menuCustomLogoutItem
    }
}
