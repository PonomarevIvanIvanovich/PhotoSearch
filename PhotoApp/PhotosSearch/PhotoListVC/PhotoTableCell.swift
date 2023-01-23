//
//  PhotoTableCell.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 15.07.2022.
//

import UIKit
import Pods_PhotosSearch

final class PhotoTableCell: UITableViewCell {
    
    static let identifire = "PhotoTableCell"
    
    let nameLabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textAlignment = .center
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        return namelabel
    }()
    
    var photoImage: UIImageView = {
        let photoImage = UIImageView()
        photoImage.contentMode = .scaleAspectFit
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        return photoImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPhotoIMageConstraint()
        setupNameLabelConstraint()
        prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage.image = nil
        nameLabel.text = nil
    }
    
    func textCell(description: String?) {
        guard let description = description else { return }
        nameLabel.text = description
    }
    
    private func setupNameLabelConstraint() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: photoImage.trailingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupPhotoIMageConstraint() {
        contentView.addSubview(photoImage)
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            photoImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
