//
//  AccessibleTextField.swift
//  throw
//
//  Created by Nitya Baddam on 11/28/25.
//

import UIKit

class AccessibleTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .roundedRect
        heightAnchor.constraint(greaterThanOrEqualToConstant: 44.0).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        borderStyle = .roundedRect
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    override var accessibilityPath: UIBezierPath? {
        get {
            guard let parentView = self.superview else { return nil }
            return UIBezierPath(rect: parentView.accessibilityFrame)
        }
        set {}
    }

    @objc private func dismissKeyboard() {
        resignFirstResponder()
    }
}
