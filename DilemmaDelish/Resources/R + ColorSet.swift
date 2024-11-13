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

extension R.ColorSet {
    enum BlackAndWhite {
        static var black: UIColor { .load(name: "Black") }
        static var white: UIColor { .load(name: "White") }
    }
}

extension R.ColorSet {
    enum GrayScale {
        static var gray5: UIColor { .load(name: "Gray5") }
        static var gray10: UIColor { .load(name: "Gray10") }
        static var gray15: UIColor { .load(name: "Gray15") }
        static var gray20: UIColor { .load(name: "Gray20") }
        static var gray30: UIColor { .load(name: "Gray30") }
        static var gray40: UIColor { .load(name: "Gray40") }
        static var gray50: UIColor { .load(name: "Gray50") }
        static var gray60: UIColor { .load(name: "Gray60") }
        static var gray70: UIColor { .load(name: "Gray70") }
        static var gray80: UIColor { .load(name: "Gray80") }
        static var gray90: UIColor { .load(name: "Gray90") }
    }
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
