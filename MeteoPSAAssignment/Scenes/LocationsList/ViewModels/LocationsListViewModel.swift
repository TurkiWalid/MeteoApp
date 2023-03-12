//
//  LocationsListViewModel.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

protocol LocationsListViewModel: UITableViewDataSource, UITableViewDelegate {
    func addLocation()
}

class LocationsListViewModelImplementation: NSObject, LocationsListViewModel{
    
    func addLocation() {
        //go to add
    }
    
    
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationListItemCellTableViewCell.reuseIdentifier) as! LocationListItemCellTableViewCell
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
