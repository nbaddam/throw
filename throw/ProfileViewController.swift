//
//  ProfileViewController.swift
//  throw
//
//  Created by Claude on 01/07/26.
//

import UIKit

class ProfileViewController: UIViewController {

    private let dataSource: SessionsDataSource
    private var sessions: [Session]
    private let padding: CGFloat = 20

    // MARK: - UI Components

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // Profile Section
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Profile picture"
        imageView.accessibilityTraits = .image
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Potter"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Passionate about pottery and ceramics"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Statistics Section
    private lazy var statisticsHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Statistics"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var totalSessionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var sessionTypeStatsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // Recent Activity Section
    private lazy var recentActivityHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Activity"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var recentSessionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Initialization

    init(dataSource: SessionsDataSource) {
        self.dataSource = dataSource
        self.sessions = dataSource.allSessions
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        setupViews()
        populateData()
    }

    // MARK: - Setup

    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        // Profile section
        let profileStackView = UIStackView(arrangedSubviews: [profileImageView, nameLabel, bioLabel])
        profileStackView.axis = .vertical
        profileStackView.spacing = 12
        profileStackView.alignment = .center

        // Statistics section
        let statsContainerView = createSectionContainer(
            header: statisticsHeaderLabel,
            content: [totalSessionsLabel, sessionTypeStatsStackView]
        )

        // Recent activity section
        let recentActivityContainerView = createSectionContainer(
            header: recentActivityHeaderLabel,
            content: [recentSessionsStackView]
        )

        contentStackView.addArrangedSubview(profileStackView)
        contentStackView.addArrangedSubview(statsContainerView)
        contentStackView.addArrangedSubview(recentActivityContainerView)

        // Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -padding * 2),

            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func createSectionContainer(header: UILabel, content: [UIView]) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(stackView)
        stackView.addArrangedSubview(header)

        for view in content {
            stackView.addArrangedSubview(view)
        }

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        return container
    }

    // MARK: - Data Population

    private func populateData() {
        // Total sessions
        let totalCount = sessions.count
        totalSessionsLabel.text = "Total Sessions: \(totalCount)"
        totalSessionsLabel.accessibilityLabel = "Total sessions: \(totalCount)"

        // Session type statistics
        let sessionTypeCounts = calculateSessionTypeCounts()
        populateSessionTypeStats(sessionTypeCounts)

        // Recent activity (last 3 sessions)
        let recentSessions = sessions.sorted(by: { $0.date > $1.date }).prefix(3)
        populateRecentActivity(Array(recentSessions))
    }

    private func calculateSessionTypeCounts() -> [SessionType: Int] {
        var counts: [SessionType: Int] = [:]

        for session in sessions {
            for type in session.types {
                counts[type, default: 0] += 1
            }
        }

        return counts
    }

    private func populateSessionTypeStats(_ counts: [SessionType: Int]) {
        // Clear existing views
        sessionTypeStatsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Sort by count descending
        let sortedTypes = counts.sorted { $0.value > $1.value }

        for (type, count) in sortedTypes {
            let statView = createSessionTypeStatView(type: type, count: count)
            sessionTypeStatsStackView.addArrangedSubview(statView)
        }

        // If no stats, show message
        if sortedTypes.isEmpty {
            let emptyLabel = UILabel()
            emptyLabel.text = "No session types recorded yet"
            emptyLabel.font = UIFont.preferredFont(forTextStyle: .body)
            emptyLabel.adjustsFontForContentSizeCategory = true
            emptyLabel.textColor = .secondaryLabel
            sessionTypeStatsStackView.addArrangedSubview(emptyLabel)
        }
    }

    private func createSessionTypeStatView(type: SessionType, count: Int) -> UIView {
        let container = UIView()
        container.backgroundColor = type.backgroundColor
        container.layer.cornerRadius = 8
        container.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "\(type.displayName): \(count)"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = type.textColor
        label.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12)
        ])

        // Accessibility
        container.isAccessibilityElement = true
        container.accessibilityLabel = "\(type.displayName): \(count) sessions"
        container.accessibilityTraits = .staticText

        return container
    }

    private func populateRecentActivity(_ recentSessions: [Session]) {
        // Clear existing views
        recentSessionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        if recentSessions.isEmpty {
            let emptyLabel = UILabel()
            emptyLabel.text = "No recent sessions"
            emptyLabel.font = UIFont.preferredFont(forTextStyle: .body)
            emptyLabel.adjustsFontForContentSizeCategory = true
            emptyLabel.textColor = .secondaryLabel
            recentSessionsStackView.addArrangedSubview(emptyLabel)
            return
        }

        for session in recentSessions {
            let sessionView = createRecentSessionView(session: session)
            recentSessionsStackView.addArrangedSubview(sessionView)
        }
    }

    private func createRecentSessionView(session: Session) -> UIView {
        let container = UIView()
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 8
        container.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = session.title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 2

        let dateLabel = UILabel()
        dateLabel.text = session.date.formattedForDisplay()
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.textColor = .secondaryLabel

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)

        container.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12)
        ])

        // Accessibility
        container.isAccessibilityElement = true
        container.accessibilityLabel = "Session: \(session.title), Date: \(session.date.formattedForDisplay())"
        container.accessibilityTraits = .staticText

        // Make it tappable
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recentSessionTapped(_:)))
        container.addGestureRecognizer(tapGesture)
        container.tag = sessions.firstIndex(where: { $0 === session }) ?? 0

        return container
    }

    // MARK: - Actions

    @objc private func recentSessionTapped(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view,
              view.tag < sessions.count else { return }

        let session = sessions[view.tag]
        let detailsVC = SessionDetailsViewController()
        detailsVC.configure(with: session)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
