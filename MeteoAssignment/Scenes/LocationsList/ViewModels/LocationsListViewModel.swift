//
//  LocationsListViewModel.swift
//  MeteoAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

protocol LocationsListViewControllerDelegate {
    func reloadTableView()
}

protocol LocationsListViewModel: UITableViewDataSource, UITableViewDelegate {
    var coordinator: LocationsListCoordinator? { get set }
    var viewDelegate: LocationsListViewControllerDelegate? { get set }
    func load()
    func addLocation()
}

class LocationsListViewModelImplementation: NSObject, LocationsListViewModel{
    var coordinator: LocationsListCoordinator?
    var locationWeatherList = [LocationWeather]()
    var viewDelegate: LocationsListViewControllerDelegate?
    
    func load(){
        locationWeatherList = LocationWeatherRepository.selectAllLocations()
        viewDelegate?.reloadTableView()
    }
    
    func addLocation() {
        coordinator?.openAddLocation()
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationWeatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationListItemCellTableViewCell.reuseIdentifier) as! LocationListItemCellTableViewCell
        let item = locationWeatherList[indexPath.row]
        cell.setup(locationName: item.name ?? "N/A", temperature: item.temperature, lastConsulted: item.updatedAt ?? Date.distantPast)
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator?.goToLocationDetails(locationWeather: locationWeatherList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            LocationWeatherRepository.deleteLocation(location: locationWeatherList[indexPath.row])
            //delete row
            locationWeatherList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
