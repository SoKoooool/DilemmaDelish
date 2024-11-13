//
//  R + ColorSet.swift
//  DilemmaDelish
//
//  Created by TORI on 11/13/24.
//

import UIKit

extension R.ColorSet {
    static var primary: UIColor { .load(name: "Primary_Color") }
    static var secondary: UIColor { .load(name: "Secondary_Color") }
    static var background: UIColor { .load(name: "Background_Color") }
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
