//
//  PhotoViewController.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 15.07.2022.
//

import UIKit

protocol PhotoViewDisplayLogic {
    func savePhotoCicl()
    func deletephotoCicl()
    func loadPhoto(model: PhotoViewModel.LoadPhoto.ViewModel)
}

final class PhotoViewController: UIViewController{

    private let imageHeartWhite = UIImage(named: "imageHeartWhite")
    private let imageHeartBlack = UIImage(named: "imageHeartBlack")
    var isSelected = Bool()
    let rightBarButtonItem = UIBarButtonItem()
    var photo: PhotoSearchModelImage!
    var photoViewInteractor: PhotoViewBusnessLogic?

    private let photoImage: UIImageView = {
        let photoImage = UIImageView()
        photoImage.contentMode = .scaleAspectFit
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        return photoImage
    }()

    private let userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.text = "Имя пользователя: "
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return userNameLabel
    }()

    private let userName: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
    }()

    private let createDateLabel: UILabel = {
        let createDateLabel = UILabel()
        createDateLabel.text = "Дата создания: "
        createDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return createDateLabel
    }()

    private let createDate: UILabel = {
        let createDate = UILabel()
        createDate.translatesAutoresizingMaskIntoConstraints = false
        return createDate
    }()

    private let likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.text = "Колличество лайков: "
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        return likesLabel
    }()

    private let likes: UILabel = {
        let likes = UILabel()

        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        loadData()
        setupConstraints()
        setupAddBarButton()
    }

    private func setup() {
        let photoViewInteractor = PhotoViewIneractor()
        let photoViewPresenter = PhotoViewPresenter()
        photoViewInteractor.photoViewPresenter = photoViewPresenter
        photoViewPresenter.photoViewController = self
        self.photoViewInteractor = photoViewInteractor
    }

    //MARK: - Action

    private func setupAddBarButton() {
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(addBarButton)
        if isSelected {
            rightBarButtonItem.image = imageHeartBlack
        }
        else {
            rightBarButtonItem.image = imageHeartWhite
        }
    }

    @objc func addBarButton() {
        if isSelected == false {
            savePhoto()
        } else {
            deletePhoto()
        }
    }

    //MARK: - logick

    private func deletePhoto() {
        photoViewInteractor?.deletePhoto(model: PhotoViewModel.DeletePhoto.Request(model: photo))
    }

    private func savePhoto() {
        photoViewInteractor?.savePhoto(model: PhotoViewModel.SavePhoto.Request(model: photo))
    }

    func loadPhoto() {
        photoViewInteractor?.loadPhoto(model: PhotoViewModel.LoadPhoto.Request(model: photo))
    }

    func loadData() {
        loadPhoto()
        photoImage.image = photo.image
        userName.text = photo.userName
        createDate.text = photo.created_at
        likes.text = String(photo.likes)
    }

    //MARK: - Setup Constraint

    private func setupConstraints() {
        setupPhotoImageConstraint()
        setupUserNameConstraint()
        setupDateLabelConstraint()
        setupLikesLabelConstraint()
        setupUserNameDataConstraint()
        setupDateLabelDataConstraint()
        setupLikesLabelDataConstraint()
    }

    private func setupPhotoImageConstraint() {
        view.addSubview(photoImage)
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
        ])
    }

    private func setupUserNameConstraint() {
        view.addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -16),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupDateLabelConstraint() {
        view.addSubview(createDateLabel)
        NSLayoutConstraint.activate([
            createDateLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor),
            createDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            createDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -16),
            createDateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupLikesLabelConstraint() {
        view.addSubview(likesLabel)
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: createDateLabel.bottomAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            likesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -16),
            likesLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupUserNameDataConstraint() {
        view.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: photoImage.bottomAnchor),
            userName.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            userName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            userName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupDateLabelDataConstraint() {
        view.addSubview(createDate)
        NSLayoutConstraint.activate([
            createDate.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor),
            createDate.leadingAnchor.constraint(equalTo: createDateLabel.trailingAnchor),
            createDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            createDate.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupLikesLabelDataConstraint() {
        view.addSubview(likes)
        NSLayoutConstraint.activate([
            likes.topAnchor.constraint(equalTo: createDateLabel.bottomAnchor),
            likes.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor),
            likes.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            likes.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


}

extension PhotoViewController: PhotoViewDisplayLogic {
    func loadPhoto(model: PhotoViewModel.LoadPhoto.ViewModel) {
        photo = model.model
        isSelected = model.saveBool
    }

    func deletephotoCicl() {
        rightBarButtonItem.image = imageHeartWhite
        isSelected = false
    }

    func savePhotoCicl() {
        rightBarButtonItem.image = imageHeartBlack
        isSelected = true
    }
}
