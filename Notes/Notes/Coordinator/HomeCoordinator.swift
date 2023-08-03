//
//  HomeCoordinator.swift
//  Notes
//
//  Created by Devarsh Bhalara on 03/08/23.
//

import Foundation
import UIKit

class HomeCoordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeVC = FBAllNotesViewController.instantiate(from: .storyboard)
        homeVC.homeCoordinator = self
        navigationController.viewControllers = [homeVC]
    }

}
