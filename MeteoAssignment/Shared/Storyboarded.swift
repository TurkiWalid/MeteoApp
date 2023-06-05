//
//  Storyboarded.swift
//  MeteoAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

protocol Storyboarded {
    static var storyboardName: String {get}
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        return vc
    }
}
