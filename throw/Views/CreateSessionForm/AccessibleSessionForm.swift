//
//  AccessibleSessionForm.swift
//  throw
//
//  Created by Nitya Baddam on 11/28/25.
//

import UIKit

class AccessibleSessionForm: UIView {

    // titleTextField is an example of an accessible label whose focus box includes both the label and the text field
    // dateTextField and bodyTextView have separate labels for comparison (notice the redundant announcements)

    struct SessionTypeSelection {
        let type: SessionType
        var isSelected: Bool
    }

    var sessionTypes: [SessionTypeSelection] = [
        SessionTypeSelection(type: .throwing, isSelected: false),
        SessionTypeSelection(type: .trimming, isSelected: false),
        SessionTypeSelection(type: .glazing, isSelected: false),
        SessionTypeSelection(type: .firing, isSelected: false),
        SessionTypeSelection(type: .handbuilding, isSelected: false)
    ]

    lazy var titleTextField: LabeledTextField = {
        let field = LabeledTextField(
            labelText: "Session Title",
            accessibilityLabel: "Session Title",
            placeholder: "e.g., Morning throwing session"
        )
        return field
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityLabel = "Session Date"

        // ideally, a hint should be provided for date format (both visually and with VoiceOver)

        return textField
    }()

    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes (Optional)"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.accessibilityLabel = "Session Notes"

        return textView
    }()

    lazy var typesHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Session Types"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false

        label.isAccessibilityElement = true
        label.accessibilityTraits = .header

        return label
    }()

    lazy var sessionTypesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save Session", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.accessibilityLabel = "Save Session"

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupKeyboardDismissal()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupKeyboardDismissal() {
        // titleTextField's delegate is already set
        dateTextField.delegate = self
    }

    private func setupViews() {
        backgroundColor = .systemBackground

        // Add all form elements
        addSubview(titleTextField)
        addSubview(dateLabel)
        addSubview(dateTextField)
        addSubview(bodyLabel)
        addSubview(bodyTextView)
        addSubview(typesHeaderLabel)
        addSubview(sessionTypesTableView)
        addSubview(saveButton)

        NSLayoutConstraint.activate([
            // Title section - AccessibleTextField handles label + field internally
            titleTextField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Date section
            dateLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            dateTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            dateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            dateTextField.heightAnchor.constraint(equalToConstant: 44),

            // Body section
            bodyLabel.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 16),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            bodyTextView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 8),
            bodyTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bodyTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bodyTextView.heightAnchor.constraint(equalToConstant: 120),

            // Types section header
            typesHeaderLabel.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: 24),
            typesHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            typesHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Table view for session types
            sessionTypesTableView.topAnchor.constraint(equalTo: typesHeaderLabel.bottomAnchor, constant: 16),
            sessionTypesTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sessionTypesTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sessionTypesTableView.heightAnchor.constraint(equalToConstant: CGFloat(sessionTypes.count * 44)),

            // Save button
            saveButton.topAnchor.constraint(equalTo: sessionTypesTableView.bottomAnchor, constant: 32),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }

    func validateForm() -> Bool {
        guard let title = titleTextField.text, !title.isEmpty else {
            // handle error
            return false
        }

        return true
    }

    func announceSuccess() {
        let message = "Session saved successfully"
        UIAccessibility.post(notification: .announcement, argument: message)
    }
}

extension AccessibleSessionForm: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Return key dismisses keyboard
        textField.resignFirstResponder()
        return true
    }
}

extension AccessibleSessionForm: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as? SwitchTableViewCell else {
            return UITableViewCell()
        }

        let sessionTypeSelection = sessionTypes[indexPath.row]
        cell.configure(with: sessionTypeSelection.type.displayName, isOn: sessionTypeSelection.isSelected)
        cell.toggleSwitch.tag = indexPath.row
        cell.toggleSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)

        return cell
    }

    @objc private func switchValueChanged(_ sender: UISwitch) {
        let index = sender.tag
        sessionTypes[index].isSelected = sender.isOn
    }
}

extension AccessibleSessionForm: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
