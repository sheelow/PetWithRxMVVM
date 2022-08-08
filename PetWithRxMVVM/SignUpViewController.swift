//
//  SignUpViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 08.08.2022.
//

import UIKit

class SignUpViewController: UIViewController {

    //MARK: - Properties
    
    private lazy var signUpLabel: UILabel = {
        let signUpLabel = UILabel()
        signUpLabel.text = "Тут регистрируемся!"
        signUpLabel.font = .systemFont(ofSize: 28)
        signUpLabel.textColor = .black
        signUpLabel.textAlignment = .center
        signUpLabel.numberOfLines = 1
        return signUpLabel
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignUpViewController()
    }

    //MARK: - Methods

    private func configureSignUpViewController() {
        view.backgroundColor = UIColor(red: 243/255, green: 198/255, blue: 255/255, alpha: 1)
        configureWelcomeLabel()
    }

    private func configureWelcomeLabel() {
        view.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.left.right.equalToSuperview().inset(50)
        }
    }
}
