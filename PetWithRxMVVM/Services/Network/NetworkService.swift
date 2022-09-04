//
//  NetworkService.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 11.08.2022.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func fetchData(completion: @escaping ([Meme]) -> Void)
}

final class NetworkService: NetworkServiceProtocol {

    enum Path {
        static let baseURL = "https://api.imgflip.com/get_memes"
    }

    func fetchData(completion: @escaping ([Meme]) -> Void) {
        AF.request(Path.baseURL, method: .get).response { data in

            switch data.result {

            case .success(let data):
                if let data = data {
                    if let result = try? JSONDecoder().decode(Profile.self, from: data) {
                        completion(result.data.memes)
                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
