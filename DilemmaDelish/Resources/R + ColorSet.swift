//
//  R + ColorSet.swift
//  DilemmaDelish
//
//  Created by TORI on 11/13/24.
//

import UIKit

extension R.ColorSet {
    static var primary: UIColor { .load(name: "Primary_Color") }
    static var primaryLighten: UIColor { .load(name: "Primary_Lighten_Color") }
    static var primaryDarken: UIColor { .load(name: "Primary_Darken_Color") }
    static var primaryDisabled: UIColor { .load(name: "Primary_Disabled_Color") }
    static var background: UIColor { .load(name: "Background_Color") }
    static var backgroundLighten: UIColor { .load(name: "Background_Lighten_Color") }
    static var backgroundDarken: UIColor { .load(name: "Background_Darken_Color") }
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

extension R.ColorSet {
    enum Red {
        static var red5: UIColor { .load(name: "Red5") }
        static var red10: UIColor { .load(name: "Red10") }
        static var red15: UIColor { .load(name: "Red15") }
        static var red20: UIColor { .load(name: "Red20") }
        static var red30: UIColor { .load(name: "Red30") }
        static var red40: UIColor { .load(name: "Red40") }
        static var red50: UIColor { .load(name: "Red50") }
        static var red60: UIColor { .load(name: "Red60") }
        static var red70: UIColor { .load(name: "Red70") }
        static var red80: UIColor { .load(name: "Red80") }
        static var red90: UIColor { .load(name: "Red90") }
    }
}

extension R.ColorSet {
    enum Green {
        static var Green5: UIColor { .load(name: "Green5") }
        static var Green10: UIColor { .load(name: "Green10") }
        static var Green15: UIColor { .load(name: "Green15") }
        static var Green20: UIColor { .load(name: "Green20") }
        static var Green30: UIColor { .load(name: "Green30") }
        static var Green40: UIColor { .load(name: "Green40") }
        static var Green50: UIColor { .load(name: "Green50") }
        static var Green60: UIColor { .load(name: "Green60") }
        static var Green70: UIColor { .load(name: "Green70") }
        static var Green80: UIColor { .load(name: "Green80") }
        static var Green90: UIColor { .load(name: "Green90") }
    }
}

extension R.ColorSet {
    enum Blue {
        static var blue5: UIColor { .load(name: "Blue5") }
        static var blue10: UIColor { .load(name: "Blue10") }
        static var blue15: UIColor { .load(name: "Blue15") }
        static var blue20: UIColor { .load(name: "Blue20") }
        static var blue30: UIColor { .load(name: "Blue30") }
        static var blue40: UIColor { .load(name: "Blue40") }
        static var blue50: UIColor { .load(name: "Blue50") }
        static var blue60: UIColor { .load(name: "Blue60") }
        static var blue70: UIColor { .load(name: "Blue70") }
        static var blue80: UIColor { .load(name: "Blue80") }
        static var blue90: UIColor { .load(name: "Blue90") }
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
