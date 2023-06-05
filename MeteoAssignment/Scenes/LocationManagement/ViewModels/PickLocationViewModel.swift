//
//  PickLocationViewModel.swift
//  MeteoAssignment
//
//  Created by Walid on 12/3/2023.
//

import Foundation
import MapKit.MKReverseGeocoder
import OpenWeatherMap

protocol PickLocationViewModelDelegate {
    func showLoader()
    func hideLoader()
}

protocol PickLocationViewModel: MKMapViewDelegate, UIGestureRecognizerDelegate {
    var coordinator: LocationManagementCoordinator? { get set }
    var viewDelegate: PickLocationViewModelDelegate? { get set }
    func didTapOnMapLocation(coordinates: CLLocationCoordinate2D)
    func lookUpCurrentLocation(from clLocation: CLLocation, completionHandler: @escaping (CLPlacemark?) -> Void )
    func addOrUpdateLocationWeather(locality: String, coordinates: CLLocationCoordinate2D, completion: @escaping(LocationWeather)->Void )
    func createALocationFrom(_ obj: OpenWeatherMapMinimalResponseModel, with name: String) -> LocationWeather
    func createUpdatePatchFrom(_ obj: OpenWeatherMap.OpenWeatherMapMinimalResponseModel) -> [String: AnyObject]
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
                addOrUpdateLocationWeather(locality: locality, coordinates: coordinates) { [self] location in
                    coordinator?.goToLocationDetails(locationWeather: location)
                }
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
    
    //MARK: Peristance & fetch management
    
    func addOrUpdateLocationWeather(locality: String, coordinates: CLLocationCoordinate2D, completion: @escaping(LocationWeather)->Void ){
        //save in db
        let openWeathModuleManager = ModuleManagerImplementation(gateway: OpenWeatherMapGatewayImplementation())
        var request = OpenWeatherMapRequestModel(lat: coordinates.latitude, lon: coordinates.longitude)
        //add parameters from locale
        if let lang = Locale.current.languageCode {
            request.lang = lang
        }
        if #available(iOS 16, *) {
            request.units = Locale.current.measurementSystem == .metric ? MetricsUnit.Metric : MetricsUnit.Imperial
        } else {
            request.units = Locale.current.usesMetricSystem ? MetricsUnit.Metric : MetricsUnit.Imperial
        }
        do {
            try openWeathModuleManager.fetchWeather(for: request) { [self] weatherl, error in
                if let error = error {
                    coordinator?.showErrorMessage(message: error)
                    return
                }
                guard weatherl != nil else {
                    coordinator?.showErrorMessage(message: "issue_happened_please_contact_dev")
                    return
                }
                
                //save in db
                var existingLocation: LocationWeather? = LocationWeatherRepository.fetchLocation(by: locality)
                if existingLocation != nil {
                    //update
                    let updatePatch = self.createUpdatePatchFrom(weatherl!)
                    LocationWeatherRepository.updateLocation(location: existingLocation!, dataToUpdate: updatePatch)
                }else {
                    //create new
                    existingLocation = createALocationFrom(weatherl!, with: locality)
                    LocationWeatherRepository.insertLocation(newObj: existingLocation!)
                }
                //nav
                completion(existingLocation!)
            }
        }
        catch {
            coordinator?.showErrorMessage(message: "issue_happened_please_contact_dev")
        }
    }
    
    func createALocationFrom(_ obj: OpenWeatherMap.OpenWeatherMapMinimalResponseModel, with name: String) -> LocationWeather {
        let location = LocationWeatherRepository.createInstance()
        location.longitude = obj.coord.lon
        location.longitude = obj.coord.lat
        if let temp = obj.main?.temp {
            location.temperature = Float(temp)
        }
        if let desc = obj.weather?.first?.description {
            location.descriptionTitle = desc
        }
        location.name = name
        return location
    }
    
    func createUpdatePatchFrom(_ obj: OpenWeatherMap.OpenWeatherMapMinimalResponseModel) -> [String: AnyObject] {
        var patchDict = [String: AnyObject]()
        if let temp = obj.main?.temp {
            patchDict["temperature"] = temp as AnyObject
        }
        if let desc = obj.weather?.first?.description {
            patchDict["descriptionTitle"] =  desc as AnyObject
        }
        return patchDict
    }
}
