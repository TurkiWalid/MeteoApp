//
//  LocationWeather+CoreDataProperties.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//
//

import Foundation
import CoreData


extension LocationWeather {

    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var timezoneDescription: String?
    @NSManaged public var timezoneFromUtc: Int64
    @NSManaged public var temperature: Float
    @NSManaged public var humidity: Int16
    @NSManaged public var clouds: Int16
    @NSManaged public var uvIndex: Float
    @NSManaged public var windSpeed: Float

}
