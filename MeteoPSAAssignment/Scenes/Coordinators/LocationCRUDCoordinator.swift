//
//  LocationCRUDCoordinator.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

class LocationManagementCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pickALocation() {
        DispatchQueue.main.async { [self] in
            let vc = PickLocationViewController.instantiate()
            let vm = PickLocationViewModelImplementation()
            vm.coordinator = self
            vc.viewModel = vm
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func promptConfirmLocation(locality: String, success: @escaping ()->Void){
        var preparedText = NSLocalizedString("Do_you_want_to_continue_with_", comment: "")
        preparedText = preparedText.replacingOccurrences(of: "%s", with: locality)
        DialogUtil.shared.createAlertDialogWithAction(
            navigationController.viewControllers.last!,
            title: NSLocalizedString("Location_picked", comment: ""),
            message: preparedText,
            buttonCancel: NSLocalizedString("Cancel", comment: ""),
            buttonGo: NSLocalizedString("Continue", comment: ""),
            successHandler: success)
    }
    
    func showErrorMessage(message: String){
        DialogUtil.shared.createAlertDialog(
            navigationController.viewControllers.last!,
            title: NSLocalizedString("Oups!", comment: ""),
            message: message)
    }
    
    func goToLocationDetails(locationWeather : LocationWeather){
        DispatchQueue.main.async { [self] in
            let vc = WeatherPreviewViewController.instantiate()
            vc.locationWeather = locationWeather
            //replace backstack
            var viewControllers = navigationController.viewControllers
            viewControllers.removeLast()
            navigationController.setViewControllers(viewControllers, animated: true)
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    
}
