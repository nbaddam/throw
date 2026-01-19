//
//  LabeledTextField.swift
//  throw
//
//  Created by Nitya Baddam on 12/11/25.
//

import UIKit

class LabeledTextField: UIView {

    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }

    weak var delegate: UITextFieldDelegate? {
        get { textField.delegate }
        set { textField.delegate = newValue }
    }

    var keyboardType: UIKeyboardType {
        get { textField.keyboardType }
        set { textField.keyboardType = newValue }
    }

    var autocapitalizationType: UITextAutocapitalizationType {
        get { textField.autocapitalizationType }
        set { textField.autocapitalizationType = newValue }
    }

    var underlyingTextField: AccessibleTextField {
        return textField
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false

        // hides label from VoiceOver since text field will announce it
        label.isAccessibilityElement = false

        return label
    }()

    private lazy var textField: AccessibleTextField = {
        let textField = AccessibleTextField()
        return textField
    }()

    init(
        labelText: String,
        accessibilityLabel: String,
        accessibilityHint: String? = nil,
        placeholder: String? = nil
    ) {
        super.init(frame: .zero)

        self.label.text = labelText
        self.textField.placeholder = placeholder
        self.textField.accessibilityLabel = accessibilityLabel
        self.textField.accessibilityHint = accessibilityHint

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        addSubview(textField)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),

            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
}
