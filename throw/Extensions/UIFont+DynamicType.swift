//
//  UIFont+DynamicType.swift
//  throw
//
//  Created by Nitya Baddam on 12/11/25.
//

import UIKit

//  Helper extension for easily creating custom fonts that support Dynamic Type
extension UIFont {

    /**
     This function creates a scaled custom font that automatically responds to Dynamic Type settings. Make sure to also set adjustsFontForContentSizeCategory = true on your UILabel, UITextView, or UITextField.

     - Parameters:
        - name: The name of your custom font
        - size: The base font size to be used as default
        - textStyle: The semantic text style to scale relative to
     - Returns: A scaled custom font, or the system font as fallback if custom font isn't available

     Example:
     ```swift
     label.font = UIFont.scaledCustomFont(
     name: "Avenir-Heavy",
     size: 24,
     textStyle: .title1
     )
     label.adjustsFontForContentSizeCategory = true
     ```
     **/
    static func scaledCustomFont(
        name: String,
        size: CGFloat,
        textStyle: UIFont.TextStyle
    ) -> UIFont {
        // Try to load the custom font
        guard let customFont = UIFont(name: name, size: size) else {
            print("⚠️ Custom font '\(name)' not found. Falling back to system font.")
            return UIFont.preferredFont(forTextStyle: textStyle)
        }

        // Scale the custom font based on the text style
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: customFont)
    }
}
