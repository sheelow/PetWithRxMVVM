//
//  LoginViewModel.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 11.08.2022.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: - LoginViewModelProtocol

protocol LoginViewModelProtocol {
    var authState: PublishSubject<FirebaseManager.AutorizationState> { get }
    func login(email: String, password: String)
}

//MARK: - LoginViewModel

final class LoginViewModel: LoginViewModelProtocol {

    //MARK: - Properties

    var authState = PublishSubject<FirebaseManager.AutorizationState>()

    private var firebaseManager: FirebaseManagerProtocol

    //MARK: - Init

    init(firebaseManager: FirebaseManagerProtocol) {
        self.firebaseManager = firebaseManager
    }

    //MARK: - Methods

    func login(email: String, password: String) {
        firebaseManager.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            self.authState.onNext(result)
        }
    }
}
