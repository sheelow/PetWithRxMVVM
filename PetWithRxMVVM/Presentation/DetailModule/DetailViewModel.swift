//
//  DetailViewModel.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 03.09.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailViewModelProtocol {
    var model: Meme { get }
    var modelState: BehaviorSubject<Meme> { get }
    func setContent()
}

final class DetailViewModel: DetailViewModelProtocol {

    //MARK: - Properties

    var model: Meme

    var modelState = BehaviorSubject<Meme>(value: Meme(id: "", name: "", url: ""))

    //MARK: - Init

    init(model: Meme) {
        self.model = model
    }

    //MARK: - Methods

    func setContent() {
        modelState.onNext(model)
    }
}
