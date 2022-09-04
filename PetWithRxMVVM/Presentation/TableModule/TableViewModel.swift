//
//  TableViewModel.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 02.09.2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol TableViewModelProtocol {
//    var model: [Meme] { get set }
    var modelState: PublishSubject<[Meme]> { get }
    var filteredData: [Meme] { get set }
    var isSearching: Bool { get set }
    func searchResults(searchText: String)
    func fetchData()
    func pushDetailViewController(model: Meme, _ navigationController: UINavigationController)
}

final class TableViewModel: TableViewModelProtocol {

    //MARK: - Properties

//    var model: [Meme] = []

    var modelState = PublishSubject<[Meme]>()

    var filteredData: [Meme] = []

    var service: NetworkServiceProtocol

    var isSearching = false

    //MARK: - Init

    init(service: NetworkServiceProtocol) {
        self.service = service
    }

    //MARK: - Methods

    func searchResults(searchText: String) {
//        self.filteredData.removeAll()
//        guard searchText.isEmpty || searchText != " " else {
//            return
//        }
//
//        for item in model {
//            let text = searchText.lowercased()
//            let isArrayCountainName = item.user?.firstName?.lowercased().range(of: text)
//            let isArrayCountainLastName = item.user?.lastName?.lowercased().range(of: text)
//            if isArrayCountainName != nil || isArrayCountainLastName != nil {
//                self.filteredData.append(item)
//            }
//        }
//
//        if searchText == "" {
//            isSearching = false
//            view?.reloadData()
//        } else {
//            isSearching = true
//            view?.reloadData()
//        }
    }

    func pushDetailViewController(model: Meme, _ navigationController: UINavigationController) {

        let detailViewModel = DetailViewModel(model: model)
        let detailViewController = DetailViewController(detailViewModel: detailViewModel)
        navigationController.pushViewController(detailViewController, animated: true)
    }

    func fetchData() {
        service.fetchData() { [weak self] memes in
            guard let self = self else { return }
            self.modelState.onNext(memes)
        }
    }
}
