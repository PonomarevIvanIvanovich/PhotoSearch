//
//  File.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 03.07.2022.
//
import UIKit
import SDWebImage

final class PhotosCollectionCell: UICollectionViewCell {
    
    static let Identifier = "PhotosCollectionViewCell"
    
    let photoImage: UIImageView = {
        let photoImage = UIImageView()
        photoImage.contentMode = .scaleAspectFill
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        return photoImage
    }()
    
    var unsplashPhoto = UIImage()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage.image = nil
    }
    
    private func setupImageView(){
        photoImage.image = unsplashPhoto
        addSubview(photoImage)
        NSLayoutConstraint.activate([
            photoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoImage.topAnchor.constraint(equalTo: self.topAnchor),
            photoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

