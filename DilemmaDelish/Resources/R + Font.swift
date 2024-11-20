//
//  R + Font.swift
//  DilemmaDelish
//
//  Created by TORI on 11/20/24.
//

import UIKit

extension R.Font {
    enum Pretendard {
        static var regular: UIFont { .load(name: "PretendardVariable-Regular") }
        static var thin: UIFont { .load(name: "PretendardVariable-Thin") }
        static var extraLight: UIFont { .load(name: "PretendardVariable-ExtraLight") }
        static var light: UIFont { .load(name: "PretendardVariable-Light") }
        static var medium: UIFont { .load(name: "PretendardVariable-Medium") }
        static var semibold: UIFont { .load(name: "PretendardVariable-Semibold") }
        static var bold: UIFont { .load(name: "PretendardVariable-Bold") }
        static var extraBold: UIFont { .load(name: "PretendardVariable-ExtraBold") }
        static var black: UIFont { .load(name: "PretendardVariable-Black") }
    }
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
