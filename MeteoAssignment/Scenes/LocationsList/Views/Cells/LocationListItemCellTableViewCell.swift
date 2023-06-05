//
//  LocationListItemCellTableViewCell.swift
//  MeteoAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

class LocationListItemCellTableViewCell: UITableViewCell {

    static let reuseIdentifier = "LocationListItemCellTableViewCell"
    
    @IBOutlet weak var locationNameLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var lastConsultedLbl: UILabel!
    
    func setup(locationName: String, temperature: Float, lastConsulted: Date) {
        locationNameLbl.text = locationName
        temperatureLbl.text = "\(temperature)"
        lastConsultedLbl.text = NSLocalizedString("Last_consulted", comment: "") + " " + lastConsulted.localizedDateAndTime
        
    }
    
    
    
}
