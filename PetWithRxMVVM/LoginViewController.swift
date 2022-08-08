//
//  LoginViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 08.08.2022.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Properties

    private lazy var loginLabel: UILabel = {
        let loginLabel = UILabel()
        loginLabel.text = "Тут логинимся!"
        loginLabel.font = .systemFont(ofSize: 28)
        loginLabel.textColor = .black
        loginLabel.textAlignment = .center
        loginLabel.numberOfLines = 1
        return loginLabel
    }()

    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 164/255, alpha: 1)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 18)
        loginButton.layer.cornerRadius = 20
//        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        return loginButton
    }()

    private lazy var dismissButton: UIButton = {
        let createAccountButton = UIButton(type: .system)
        createAccountButton.backgroundColor = UIColor(red: 243/255, green: 198/255, blue: 255/255, alpha: 1)
        createAccountButton.setTitle("Назад", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.titleLabel?.font = .systemFont(ofSize: 18)
        createAccountButton.layer.cornerRadius = 20
        createAccountButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        return createAccountButton
    }()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginViewController()
    }

    //MARK: - Methods
    
    private func configureLoginViewController() {
        view.backgroundColor = UIColor(red: 171/255, green: 151/255, blue: 255/255, alpha: 1)
        configureWelcomeLabel()
        configureDismissButton()
        configureLoginButton()
    }

    private func configureWelcomeLabel() {
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.left.right.equalToSuperview().inset(50)
        }
    }
    
    private func configureDismissButton() {
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
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
            make.bottom.equalTo(dismissButton.snp.top).offset(-15)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }
    
    @objc
    func dismissButtonClicked() {
        self.dismiss(animated: true)
    }
}
