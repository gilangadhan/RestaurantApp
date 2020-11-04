//
//  StringFormatter.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 29/10/20.
//

import Foundation

public extension Double {
    var formateRate: String {
        return String(format: "%.1f", self)
    }
}
