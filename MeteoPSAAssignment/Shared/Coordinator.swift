//
//  Coordinator.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

public protocol Coordinator: AnyObject {
    var navigationController : UINavigationController { get set }
    init(navigationController: UINavigationController)
}
