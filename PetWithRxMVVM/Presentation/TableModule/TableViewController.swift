//
//  TableViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 08.08.2022.
//

import UIKit
import SnapKit

final class TableViewController: BaseViewController, UITableViewDelegate {

    //MARK: - Properties

    private var tableViewModel: TableViewModelProtocol

    private let items = ["Мемы", "Избранные"]

    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()

    private lazy var tableView = UITableView()

    //MARK: - Lifecycle

    init(tableViewModel: TableViewModelProtocol) {
        self.tableViewModel = tableViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Мемасики"
        tableView.rx.setDelegate(self).disposed(by: disposeBag)

        bindTableView()
        configureTableView()
        configureSearchBar()
        reloadData()
    }

    //MARK: - Methods

    private func bindTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")

        tableViewModel.modelState
            .bind(to: tableView.rx.items(cellIdentifier: "TableViewCell", cellType: TableViewCell.self)) { row, mem, cell in
            cell.backgroundColor = .milkWhite
            cell.model = TableViewCellModel(id: mem.id ?? "",
                                            name: mem.name ?? "",
                                            picture: mem.url ?? "")
            cell.setContent()
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Meme.self)
            .subscribe(onNext: { [weak self] mem in
            guard let self = self, let navigationController = self.navigationController else { return }
            self.tableViewModel.pushDetailViewController(model: mem, navigationController)
        }).disposed(by: disposeBag)

        tableViewModel.fetchData()
    }

    private func configureTableView() {
        view.backgroundColor = .milkWhite

        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.isActive = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }

    @objc
    private func didChangeSegment(_ segmentedControl: UISegmentedControl) {
        
    }
}

//MARK: - UISearchBarDelegate

extension TableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.presenter.searchResults(searchText: searchText)
        }
    }
}
