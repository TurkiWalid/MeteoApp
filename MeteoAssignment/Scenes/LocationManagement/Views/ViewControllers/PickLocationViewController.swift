//
//  PickLocationViewController.swift
//  MeteoAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit
import MapKit

class PickLocationViewController: UIViewController, Storyboarded, PickLocationViewModelDelegate {
    static var storyboardName: String {
        return "LocationManagement"
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: PickLocationViewModel?
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        viewModel?.viewDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTitles()
    }
    
    private func setupTitles(){
        self.title = NSLocalizedString("map", comment: "")
    }
    
    private func setupMap() {
        mapView.delegate = viewModel
        let tapGestureHandler = UITapGestureRecognizer(target: self, action: #selector(self.revealRegionOnPress(sender:)))
        mapView.addGestureRecognizer(tapGestureHandler)
    }
    
    @objc func revealRegionOnPress(sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        viewModel?.didTapOnMapLocation(coordinates: locationCoordinate)
    }
    
    func showLoader(){
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let barButton = UIBarButtonItem(customView: activityIndicator!)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        activityIndicator!.startAnimating()
    }
    
    func hideLoader(){
        activityIndicator?.stopAnimating()
    }
    
}
