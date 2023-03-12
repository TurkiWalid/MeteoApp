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
        let instanciated = LocationsListViewController.instantiate()
        //some init
        self.navigationController.pushViewController(instanciated, animated: true)
    }

}
