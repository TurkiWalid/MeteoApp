//
//  UILabelExtension.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import UIKit

extension UILabel {
    @IBInspectable var localizableText: String? {
        get { return text }
        set(value) { text = NSLocalizedString(value!, comment: "") }
    }
}
