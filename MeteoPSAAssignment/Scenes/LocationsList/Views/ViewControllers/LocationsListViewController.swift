//
//  LocationsListViewController.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

class LocationsListViewController: UIViewController, Storyboarded {
    
    static var storyboardName: String {
        return "AllLocations"
    }

    @IBOutlet weak var locationsTableView: UITableView!
    
    var viewModel: LocationsListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTitles()
    }
    
    private func setUpTableView() {
        locationsTableView.estimatedRowHeight = 80
        locationsTableView.rowHeight = UITableView.automaticDimension
        
        //For bottom a clean bottom scrolling
        locationsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        
        let cell = UINib(nibName: LocationListItemCellTableViewCell.reuseIdentifier, bundle:nil)
        locationsTableView.register(cell,forCellReuseIdentifier: LocationListItemCellTableViewCell.reuseIdentifier)
        
        locationsTableView.dataSource = viewModel
        locationsTableView.delegate = viewModel
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTitles() {
        self.title = NSLocalizedString("Locations", comment: "")
    }
    
    @IBAction func addLocation(_ sender: Any) {
        
    }
    
    
    
}
