//
//  BaseViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 01.09.2022.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
