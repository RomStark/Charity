//
//  TabViewController.swift
//  Charity
//
//  Created by Al Stark on 30.11.2022.
//

import UIKit

class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    func generateTabBar() {
        viewControllers = [
            generateVC(viewcontroller: UINavigationController(rootViewController: MainTableViewController()), title: "таблица", image: UIImage(systemName: "arrow.counterclockwise")),
            generateVC(viewcontroller: MapViewController(), title: "карта", image: UIImage(systemName: "arrow.counterclockwise"))
        ]
    }
    
    func generateVC(viewcontroller: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewcontroller.tabBarItem.title = title
        viewcontroller.tabBarItem.image = image
        return viewcontroller
    }

}
