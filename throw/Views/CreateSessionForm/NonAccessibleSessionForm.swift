//
//  NonAccessibleSessionForm.swift
//  throw
//
//  Created by Nitya Baddam on 12/11/25.
//

import UIKit

class NonAccessibleSessionForm: UIView {

    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Session Title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Date"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Session notes..."
        textView.textColor = .lightGray
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    lazy var typesLabel: UILabel = {
        let label = UILabel()
        label.text = "Session Types"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var throwingCheckbox: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()

    lazy var trimmingCheckbox: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()

    lazy var glazingCheckbox: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()

    lazy var throwingLabel: UILabel = {
        let label = UILabel()
        label.text = "Throwing"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var trimmingLabel: UILabel = {
        let label = UILabel()
        label.text = "Trimming"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var glazingLabel: UILabel = {
        let label = UILabel()
        label.text = "Glazing"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .systemBackground

        addSubview(titleTextField)
        addSubview(dateTextField)
        addSubview(bodyTextView)
        addSubview(typesLabel)

        // Checkbox rows
        addSubview(throwingLabel)
        addSubview(throwingCheckbox)
        addSubview(trimmingLabel)
        addSubview(trimmingCheckbox)
        addSubview(glazingLabel)
        addSubview(glazingCheckbox)

        addSubview(saveButton)

        NSLayoutConstraint.activate([
            // Title field
            titleTextField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 44),

            // Date field
            dateTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            dateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            dateTextField.heightAnchor.constraint(equalToConstant: 44),

            // Body text view
            bodyTextView.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 16),
            bodyTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bodyTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bodyTextView.heightAnchor.constraint(equalToConstant: 120),

            // Types section
            typesLabel.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: 24),
            typesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            // Throwing
            throwingLabel.topAnchor.constraint(equalTo: typesLabel.bottomAnchor, constant: 16),
            throwingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            throwingCheckbox.centerYAnchor.constraint(equalTo: throwingLabel.centerYAnchor),
            throwingCheckbox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Trimming
            trimmingLabel.topAnchor.constraint(equalTo: throwingLabel.bottomAnchor, constant: 16),
            trimmingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            trimmingCheckbox.centerYAnchor.constraint(equalTo: trimmingLabel.centerYAnchor),
            trimmingCheckbox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Glazing
            glazingLabel.topAnchor.constraint(equalTo: trimmingLabel.bottomAnchor, constant: 16),
            glazingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            glazingCheckbox.centerYAnchor.constraint(equalTo: glazingLabel.centerYAnchor),
            glazingCheckbox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Save button
            saveButton.topAnchor.constraint(equalTo: glazingCheckbox.bottomAnchor, constant: 32),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }

    func validateForm() -> Bool {
        guard let title = titleTextField.text, !title.isEmpty else {
            titleTextField.layer.borderColor = UIColor.red.cgColor
            return false
        }
        return true
    }
}
