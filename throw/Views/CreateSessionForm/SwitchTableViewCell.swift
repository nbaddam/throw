//
//  SwitchTableViewCell.swift
//  throw
//
//  Created by Nitya Baddam on 1/18/26.
//

import UIKit

// could be further abstracted into a reusable component if needed
// e.g. AccessibleAccessoryViewTableViewCell
// configure method can accept different accessory views
class SwitchTableViewCell: UITableViewCell {

    static let identifier = "SwitchTableViewCell"

    lazy var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        selectionStyle = .none
        accessoryView = toggleSwitch // this allows the whole cell to be focused and act like the switch, complete with actions and the appropriate traits
        textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        textLabel?.adjustsFontForContentSizeCategory = true
    }

    func configure(with title: String, isOn: Bool) {
        textLabel?.text = title
        toggleSwitch.isOn = isOn
        toggleSwitch.accessibilityLabel = title
    }
}
