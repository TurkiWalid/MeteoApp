//
//  AppCoordinator.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LocationsListViewController.instantiate()
        vc.viewModel = LocationsListViewModelImplementation()
        self.navigationController.pushViewController(vc, animated: true)
    }

}
