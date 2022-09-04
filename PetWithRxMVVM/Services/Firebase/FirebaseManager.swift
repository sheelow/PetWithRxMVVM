//
//  FirebaseManager.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 11.08.2022.
//

import Foundation
import Firebase
import FirebaseAuth

protocol FirebaseManagerProtocol {
    func createUser(name: String, lastName: String, email: String, password: String, completion: @escaping (FirebaseManager.RegistationState) -> Void)
    func login(email: String, password: String, completion: @escaping (FirebaseManager.AutorizationState) -> Void)
}

final class FirebaseManager: FirebaseManagerProtocol {

    enum AutorizationState {
        case succsess
        case failure
    }

    enum RegistationState {
        case succsess
        case failure
    }

    //MARK: - CreateUser

    func createUser(name: String, lastName: String, email: String, password: String, completion: @escaping (FirebaseManager.RegistationState) -> Void) {

        Auth.auth().createUser(withEmail: email, password: password) { result, error in

            let database = Firestore.firestore()
            database.collection("users").addDocument(data: [
                "firstName": name,
                "lastName": lastName,
                "uid":result?.user.uid ?? ""]) { error in
                    if error != nil {
                        completion(.failure)
                    }
                }

            completion(.succsess)
        }
    }

    //MARK: - Login

    func login(email: String, password: String, completion: @escaping (FirebaseManager.AutorizationState) -> Void) {

        Auth.auth().signIn(withEmail: email, password: password) { result, error in

            if error != nil {
                completion(.failure)
            } else {
                completion(.succsess)
            }
        }
    }
}
