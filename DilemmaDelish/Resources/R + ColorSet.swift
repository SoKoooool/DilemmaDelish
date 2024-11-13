//
//  R + ColorSet.swift
//  DilemmaDelish
//
//  Created by TORI on 11/13/24.
//

import UIKit

extension R.ColorSet {
    
}

extension UIColor {
    static func load(name: String) -> UIColor {
        guard let color = UIColor(named: name, in: R.bundle, compatibleWith: nil) else {
            assert(false, "\(name) Failed to load color")
            return UIColor()
        }
        return color
    }
}
