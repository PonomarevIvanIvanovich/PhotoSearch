//
//  MyTabBar.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 03.07.2022.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            generateNavigationController(rootViewController: PhotoCollectionVС(collectionViewLayout: UICollectionViewFlowLayout()), image: "image3"),
            generateNavigationController(rootViewController: PhotoListVC(), image: "image4")
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, image: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = UIImage(named: image)
        return navigationVC
    }
}
