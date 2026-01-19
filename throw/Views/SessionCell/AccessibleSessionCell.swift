//
//  AccessibleSessionCell.swift
//  throw
//
//  Created by Nitya Baddam on 11/28/25.
//

import UIKit

class AccessibleSessionCell: UICollectionViewCell {
    let padding: CGFloat = 18

    let rightImageView = RightImageView()
    let leftSummaryView = LeftSummaryView()

    private var currentSession: Session?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupViews()
        setupAccessibility()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        self.backgroundColor = UIColor.secondarySystemBackground
        self.layer.cornerRadius = 16

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
    }

    func setupViews() {
        contentView.addSubview(rightImageView)
        contentView.addSubview(leftSummaryView)

        NSLayoutConstraint.activate([
            leftSummaryView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            leftSummaryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            leftSummaryView.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -padding),

            rightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            rightImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            rightImageView.heightAnchor.constraint(equalTo: rightImageView.widthAnchor)
        ])
    }

    private func setupAccessibility() {
        // group all elements into a single coherent element
        self.isAccessibilityElement = true

        // so VO announces trait of button for tappable cells
        self.accessibilityTraits = .button
    }

    func configure(with session: Session) {
        leftSummaryView.configure(title: session.title, date: session.date.formattedForDisplay(), sessionTypes: session.types)
        rightImageView.configure(images: session.images)

        self.currentSession = session

        configureAccessibilityLabel(for: session)
        configureAccessibilityActions(for: session)
    }

    private func configureAccessibilityLabel(for session: Session) {
        var labelComponents: [String] = []

        labelComponents.append(session.title)
        labelComponents.append(session.date.formattedForDisplay())

        // adding session types
        if !session.types.isEmpty {
            let typeNames = session.types.map { $0.displayName }
            let typesString = typeNames.joined(separator: ", ")
            labelComponents.append("Session types: \(typesString)")
        }

        // adding image counts
        let imageCount = session.images.count
        if imageCount == 1 {
            labelComponents.append("1 image")
        } else {
            labelComponents.append("\(imageCount) images")
        }

        self.accessibilityLabel = labelComponents.joined(separator: ". ")
    }

    private func configureAccessibilityActions(for session: Session) {
        var actions: [UIAccessibilityCustomAction] = []

        let shareAction = UIAccessibilityCustomAction(
            name: "Share session",
            target: self,
            selector: #selector(shareAction)
        )
        actions.append(shareAction)

        let imagesAction = UIAccessibilityCustomAction(
            name: "View all images",
            target: self,
            selector: #selector(viewImagesAction)
        )
        actions.append(imagesAction)

        self.accessibilityCustomActions = actions
    }

    @objc private func shareAction() -> Bool {
        // in a real implementation, this would present share sheet
        NotificationCenter.default.post(
            name: .sessionCellShare,
            object: nil,
            userInfo: ["session": currentSession as Any]
        )

        // announce feedback to user
        // may be redundant in the case that a new screen is presented, but this is a great way to notify the user of a background action
        UIAccessibility.post(notification: .announcement, argument: "Sharing \(currentSession?.title ?? "session")")
        return true
    }

    @objc private func viewImagesAction() -> Bool {
        // in a real implementation, this may open an image gallery
        NotificationCenter.default.post(
            name: .sessionCellViewImages,
            object: nil,
            userInfo: ["session": currentSession as Any]
        )

        // announce feedback to user
        let imageCount = currentSession?.images.count ?? 0
        UIAccessibility.post(notification: .announcement, argument: "Viewing \(imageCount) images")
        return true
    }
}

extension Notification.Name {
    static let sessionCellViewDetails = Notification.Name("sessionCellViewDetails")
    static let sessionCellShare = Notification.Name("sessionCellShare")
    static let sessionCellViewImages = Notification.Name("sessionCellViewImages")
}
