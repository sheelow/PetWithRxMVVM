//
//  DetailViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 03.09.2022.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: BaseViewController {

    // MARK: - Properties

    var isSelectedButton = false

    var likeButton: UIButton = {
        let likeButton = UIButton(type: .system)
        likeButton.setTitle("Добавить в избранные", for: .normal)
        likeButton.setTitleColor(.black, for: .normal)
        likeButton.layer.borderWidth = 3.0
        likeButton.layer.borderColor = CGColor.init(gray: 0, alpha: 1)
        likeButton.titleLabel?.font = .systemFont(ofSize: 18)
        likeButton.layer.cornerRadius = 20
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return likeButton
    }()

    private var detailViewModel: DetailViewModelProtocol

    private lazy var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFit
        return photoImageView
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 24)
        nameLabel.textColor = .black
        return nameLabel
    }()

    //MARK: - Lifecycle

    init(detailViewModel: DetailViewModelProtocol) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Мемасик"
        configureDetailViewController()

        detailViewModel.setContent()
        detailViewModel.modelState.subscribe(onNext: { [weak self] mem in
            print(mem)
            guard let self = self else { return }

            self.nameLabel.text = mem.name
            self.photoImageView.kf.setImage(with: URL(string: self.detailViewModel.model.url ?? ""), placeholder: nil)
        }).disposed(by: disposeBag)
    }

    // MARK: - Methods

    private func configureDetailViewController() {
        view.backgroundColor = .milkWhite
        configurePhotoImageView()
        configureNameLabel()
        configureLikeButton()
    }

    private func configurePhotoImageView() {
        view.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(view.frame.height / 2)
        }
    }

    private func configureNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
        }
    }

    private func configureLikeButton() {
        view.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }

    @objc
    private func likeButtonTapped() {
        isSelectedButton.toggle()
        if isSelectedButton {
            likeButton.setTitle("Удалить из избранных", for: .normal)
            likeButton.setTitleColor(.red, for: .normal)
        } else {
            likeButton.setTitle("Добавить в избранные", for: .normal)
            likeButton.setTitleColor(.black, for: .normal)
        }
    }
}
