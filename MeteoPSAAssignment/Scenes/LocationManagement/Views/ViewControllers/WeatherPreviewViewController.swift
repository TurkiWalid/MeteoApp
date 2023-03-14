//
//  WeatherPreviewViewController.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 15/3/2023.
//

import UIKit

class WeatherPreviewViewController: UIViewController, Storyboarded {
    static var storyboardName: String {
        return "LocationManagement"
    }
    
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    var locationWeather: LocationWeather!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("weather_details", comment: "")
        locationName.text = locationWeather.name
        temperatureLabel.text = "\(locationWeather.temperature)"
        descriptionLabel.text = locationWeather.descriptionTitle
        updatedAtLabel.text = NSLocalizedString("Last_consulted", comment: "") + " " + (locationWeather.updatedAt ?? Date()).localizedDateAndTime
    }
    

}
