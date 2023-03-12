//
//  PickLocationViewModel.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import Foundation
import MapKit.MKReverseGeocoder

protocol PickLocationViewModelDelegate {
    func showLoader()
    func hideLoader()
}

protocol PickLocationViewModel: MKMapViewDelegate, UIGestureRecognizerDelegate {
    var coordinator: LocationManagementCoordinator? { get set }
    var viewDelegate: PickLocationViewModelDelegate? { get set }
    func didTapOnMapLocation(coordinates: CLLocationCoordinate2D)
    func lookUpCurrentLocation(from clLocation: CLLocation, completionHandler: @escaping (CLPlacemark?) -> Void )
}


class PickLocationViewModelImplementation: NSObject, PickLocationViewModel {
    var coordinator: LocationManagementCoordinator?
    var viewDelegate: PickLocationViewModelDelegate?
    
    func didTapOnMapLocation(coordinates: CLLocationCoordinate2D) {
        viewDelegate?.showLoader()
        let clLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        self.lookUpCurrentLocation(from: clLocation, completionHandler: { [self] placemark in
            viewDelegate?.hideLoader()
            guard let placemark = placemark, let locality = placemark.locality?.description else {
                return
            }
            coordinator?.promptConfirmLocation(locality: locality, success: { [self] in
                //create a location
                //save in db
                coordinator?.goToLocationDetails(/*location*/)
            })
        })
    }
    
    
    
    ///from Apple doc
    func lookUpCurrentLocation(from clLocation: CLLocation, completionHandler: @escaping (CLPlacemark?) -> Void ) {
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(clLocation,
                                        completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation)
            }
            else {
                // An error occurred during geocoding.
                completionHandler(nil)
            }
        })
        
    }
}
