//
//  DateExtension.swift
//  MeteoPSAAssignment
//
//  Created by Walid on 12/3/2023.
//

import Foundation

extension Date {
    var localizedDateAndTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat (fromTemplate: "d/MM/yyyy j:m",options:0, locale: Locale.current)
        return dateFormatter.string(from: self)
    }
}
