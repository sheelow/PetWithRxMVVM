//
//  LoginViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 08.08.2022.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    //MARK: - Properties

    private lazy var welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Добро пожаловать!"
        welcomeLabel.font = .systemFont(ofSize: 28)
        welcomeLabel.textColor = .black
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 1
        return welcomeLabel
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.backgroundColor = UIColor(red: 171/255, green: 151/255, blue: 255/255, alpha: 1)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 18)
        loginButton.layer.cornerRadius = 20
//        loginButton.addTarget(self, action: #selector(), for: .touchUpInside)
        return loginButton
    }()
    
    private lazy var createAccountButton: UIButton = {
        let createAccountButton = UIButton(type: .system)
        createAccountButton.backgroundColor = UIColor(red: 243/255, green: 198/255, blue: 255/255, alpha: 1)
        createAccountButton.setTitle("Создать аккаунт", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.titleLabel?.font = .systemFont(ofSize: 18)
        createAccountButton.layer.cornerRadius = 20
//        createAccountButton.addTarget(self, action: #selector(buttonCreateAccountClicked), for: .touchUpInside)
        return createAccountButton
    }()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginView()
    }

    //MARK: - Methods

    private func configureLoginView() {
        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        configureWelcomeLabel()
        configureСreateAccountButton()
        configureLoginButton()
    }

    private func configureWelcomeLabel() {
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.left.right.equalToSuperview().inset(50)
        }
    }

    private func configureСreateAccountButton() {
        view.addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(createAccountButton.snp.top).offset(-15)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }
}
