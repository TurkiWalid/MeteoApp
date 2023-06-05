//
//  LocationWeather+CoreDataProperties.swift
//  MeteoAssignment
//
//  Created by Walid on 12/3/2023.
//
//

import Foundation
import CoreData


extension LocationWeather {

    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var name: String?
    @NSManaged public var temperature: Float
    @NSManaged public var descriptionTitle: String?
    @NSManaged public var updatedAt: Date?

}
