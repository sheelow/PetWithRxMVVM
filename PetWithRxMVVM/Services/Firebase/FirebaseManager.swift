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
    func login(email: String, password: String, completion: @escaping (AutorizationState) -> Void)
}

enum AutorizationState {
    case succsess
    case failure
}

final class FirebaseManager: FirebaseManagerProtocol {
    
    func login(email: String, password: String, completion: @escaping (AutorizationState) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error != nil {
                completion(.failure)
            } else {
                completion(.succsess)
            }
        }
    }
}
