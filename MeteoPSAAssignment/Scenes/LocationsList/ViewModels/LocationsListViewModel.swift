//
//  LocationsListViewModel.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

protocol LocationsListViewModel: UITableViewDataSource, UITableViewDelegate {
    var coordinator: LocationsListCoordinator? { get set }
    func addLocation()
}

class LocationsListViewModelImplementation: NSObject, LocationsListViewModel{
    var coordinator: LocationsListCoordinator?
    
    func addLocation() {
        coordinator?.openAddLocation()
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationListItemCellTableViewCell.reuseIdentifier) as! LocationListItemCellTableViewCell
        cell.setup()
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to details
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete db
            //delete row
        }
    }
    
}
