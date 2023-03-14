//
//  LocationsListCoordinator.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

class LocationsListCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        DispatchQueue.main.async { [self] in
            let vc = LocationsListViewController.instantiate()
            let vm = LocationsListViewModelImplementation()
            vm.coordinator = self
            vc.viewModel = vm
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func openAddLocation(){
        let coordinator = LocationManagementCoordinator(navigationController: navigationController)
        coordinator.pickALocation()
    }
    
    func goToLocationDetails(locationWeather : LocationWeather){
        DispatchQueue.main.async { [self] in
            let vc = WeatherPreviewViewController.instantiate()
            vc.locationWeather = locationWeather
            navigationController.pushViewController(vc, animated: true)
        }
    }

}
