//
//  ViewController.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 03.07.2022.
//

import UIKit

protocol PhotoListDisplay {
    func loadData(model: PhotoListModel.loadPhoto.ViewModel)
    func openPhoto(model: PhotoListModel.OpenPhoto.ViewModel)
    func deletePhotoLogic(model: PhotoListModel.DeletePhoto.ViewModel)
}

final class PhotoListVC: UITableViewController {

    var photoListInteractor: PhotoListBusnessLogic?
    var photoData = [PhotoSearchModelImage]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCleanSwift()
        setupTableView()
        tableView.rowHeight = 104
    }

    private func setupCleanSwift() {
        let photoListPresenter = PhotoListPtresrnter()
        let photoListInteractor = PhotoListInteractor()
        photoListInteractor.photoListPresenter = photoListPresenter
        photoListPresenter.photoListVC = self
        self.photoListInteractor = photoListInteractor
    }

    private func loadData() {
        photoListInteractor?.loadData()
    }

    private func deletePhoto(id: Int){
        photoListInteractor?.deletePhoto(model:
                                            PhotoListModel.DeletePhoto.Request(modelID: photoData[id].id))
    }

    private func setupTableView() {
        navigationItem.title = "Избранное"
        tableView.register(PhotoTableCell.self, forCellReuseIdentifier: PhotoTableCell.identifire)
    }

    func tappedPhotoCell(photo: PhotoSearchModelImage ) {
        let photoViewController = PhotoViewController()
        photoViewController.photo = photo
        photoViewController.isSelected = true
        navigationController?.pushViewController(photoViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableCell.identifire, for: indexPath)
                as? PhotoTableCell else {
            return UITableViewCell()
        }
        cell.photoImage.image = photoData[indexPath.row].image
        cell.nameLabel.text = photoData[indexPath.row].userName
        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        photoListInteractor?.openPhoto(requestModel: PhotoListModel.OpenPhoto.Request(model: photoData[indexPath.row]))
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") {(contextualAction, view, boolValue) in
            self.deletePhoto(id: indexPath.row)
            self.photoData.remove(at: indexPath.row)//????
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}

extension PhotoListVC: PhotoListDisplay {
    func deletePhotoLogic(model: PhotoListModel.DeletePhoto.ViewModel) {
        tableView.reloadData()
    }

    func openPhoto(model: PhotoListModel.OpenPhoto.ViewModel) {
        tappedPhotoCell(photo: model.model)
    }

    func loadData(model: PhotoListModel.loadPhoto.ViewModel) {
        photoData = model.model
        tableView.reloadData()
    }
}
