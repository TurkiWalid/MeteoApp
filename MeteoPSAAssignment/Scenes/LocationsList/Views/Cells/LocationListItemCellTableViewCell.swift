//
//  LocationListItemCellTableViewCell.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

class LocationListItemCellTableViewCell: UITableViewCell {

    static let reuseIdentifier = "LocationListItemCellTableViewCell"
    
    @IBOutlet weak var locationNameLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var lastConsultedLbl: UILabel!
    
    func setup() {
        self.lastConsultedLbl.text = NSLocalizedString("Last_consulted", comment: "") + " " + Date().localizedDateAndTime
    }
    
    
    
}
