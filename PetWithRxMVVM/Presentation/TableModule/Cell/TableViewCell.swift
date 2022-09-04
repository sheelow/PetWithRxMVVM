//
//  TableViewCell.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 02.09.2022.
//

import UIKit
import SnapKit
import Kingfisher

final class TableViewCell: UITableViewCell {

    //MARK: - Properties

    var model: TableViewCellModel?

    var isSelectedButton = false

    var likeButton: UIButton = {
        let likeButton = UIButton(type: .system)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeButton.tintColor = .systemGray
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return likeButton
    }()

    private lazy var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = 10
        photoImageView.layer.masksToBounds = true
        return photoImageView
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 16)
        nameLabel.textColor = .black
        return nameLabel
    }()

    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        isSelectedButton = false
        likeButton.tintColor = isSelectedButton ? .red : .systemGray
    }

    func setContent() {
        nameLabel.text = self.model?.name
        photoImageView.kf.setImage(with: URL(string: model?.picture  ?? ""), placeholder: nil)
    }

    private func configureCell() {
        configurePhotoImage()
        configureNameLabel()
        configureLikeButton()
    }

    private func configurePhotoImage() {
        addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(10)
            make.width.height.equalTo(150)
        }
    }

    private func configureNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(51)
            make.top.equalToSuperview().inset(10)
        }
    }

    private func configureLikeButton() {
        accessoryView = likeButton
        addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(18)
        }
    }

    @objc
    private func likeButtonTapped() {
        isSelectedButton.toggle()
        likeButton.tintColor = isSelectedButton ? .red : .systemGray
        
    }
}
