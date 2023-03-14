//
//  LocationWeatherRepository.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import Foundation
import CoreData

class LocationWeatherRepository {
    @discardableResult
    static func insertLocation(newObj: LocationWeather) -> Bool{
        var succeed = true
        newObj.updatedAt = Date()
        do{
            try CoreDataHelper.shared.context.save()
        }catch{
            print("Error saving \(error)" )
            succeed = false
        }
        return succeed
    }
    
    static func selectAllLocations() -> [LocationWeather] {
        var locations = [LocationWeather]()
        let fetchRequest: NSFetchRequest<LocationWeather> = NSFetchRequest<LocationWeather>(entityName: "LocationWeather")
        do {
            locations = try CoreDataHelper.shared.context.fetch(fetchRequest)
        }catch{
            print(error)
        }
        return locations
    }
    
    static func fetchLocation(by name: String) -> LocationWeather? {
        var location: LocationWeather?
        let fetchRequest: NSFetchRequest<LocationWeather> = NSFetchRequest<LocationWeather>(entityName: "LocationWeather")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            location = try CoreDataHelper.shared.context.fetch(fetchRequest).first
        }catch{
            print(error)
        }
        return location
    }
    
    static func deleteLocation(location: LocationWeather) {
        CoreDataHelper.shared.context.delete(location)
    }
    
    static func updateLocation(location: LocationWeather, dataToUpdate: [String: AnyObject]){
        location.updatedAt = Date()
        if let newTemp = dataToUpdate["temperature"] {
            location.temperature = (newTemp as! NSNumber).floatValue
        }
        if let situation = dataToUpdate["descriptionTitle"] {
            location.descriptionTitle = situation as? String
        }
        do{
            try CoreDataHelper.shared.context.save()
        }catch{
            print(error)
        }
    }
    
    static func createInstance() -> LocationWeather {
        let location = NSEntityDescription.insertNewObject(forEntityName: "LocationWeather", into: CoreDataHelper.shared.context) as! LocationWeather
        return location
    }
}
