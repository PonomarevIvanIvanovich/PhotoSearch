//
//  File.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 12.07.2022.
//

import Foundation
import UIKit

//final class PhotosCollectionVC: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
//
//    init() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        super.init(frame: .zero, collectionViewLayout: layout)
//        setupCollection()
//        backgroundColor = .orange
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupCollection() {
//        delegate = self
//        dataSource = self
//        register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.Identifier)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = dequeueReusableCell(withReuseIdentifier: PhotosCell.Identifier, for: indexPath)
//        cell.backgroundColor = .gray
//        return cell
//    }
//
//
//}
//
//
