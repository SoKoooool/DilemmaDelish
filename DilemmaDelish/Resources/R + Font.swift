//
//  R + Font.swift
//  DilemmaDelish
//
//  Created by TORI on 11/20/24.
//

import UIKit

extension R.Font {
    
}

extension UIFont {
    static func load(name: String) -> UIFont {
        guard let font = UIFont(name: name, size: 12) else {
            assert(false, "\(name) Failed to load font")
            return UIFont.systemFont(ofSize: 12)
        }
        return font
    }
}
