//
//  FeedViewController.swift
//  throw
//
//  Created by Nitya Baddam on 11/15/25.
//

import UIKit

class FeedViewController: UIViewController {

    var collectionView: UICollectionView!
    var sessions: [Session]
    private let dataSource: SessionsDataSource

    // DEMO TOGGLE: Change this boolean to switch between implementations
    // true = Accessible cells with grouping and custom actions
    // false = Non-accessible cells (default implementation)
    private let useAccessibleCells = true

    init(dataSource: SessionsDataSource) {
        self.dataSource = dataSource
        self.sessions = dataSource.allSessions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Add profile button to navigation bar
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(profileButtonTapped)
        )
        profileButton.accessibilityLabel = "Profile"
        navigationItem.rightBarButtonItem = profileButton

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        // Register BOTH cell types for comparison
        collectionView.register(SessionCollectionViewCell.self, forCellWithReuseIdentifier: "SessionCell")
        collectionView.register(AccessibleSessionCell.self, forCellWithReuseIdentifier: "AccessibleSessionCell")

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectionView)

        // To support landscape orientation: important that the frame of the UICollectionView is not explictly set at initialization above. instead, set to .zero and use constraints so that AutoLayout can handle the resizing on screen rotations.
        // Also set item size using UICollectionViewDelegateFlowLayout's override method `func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize`
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Listen for custom action notifications from AccessibleSessionCell
        setupNotificationObservers()
    }

    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleShare(_:)),
            name: .sessionCellShare,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleViewImages(_:)),
            name: .sessionCellViewImages,
            object: nil
        )
    }

    @objc private func handleShare(_ notification: Notification) {
        guard let session = notification.userInfo?["session"] as? Session else { return }
        // In a real app, this would present a share sheet
        print("Sharing session: \(session.title)")
    }

    @objc private func handleViewImages(_ notification: Notification) {
        guard let session = notification.userInfo?["session"] as? Session else { return }
        // In a real app, this would open an image gallery
        print("Viewing images for session: \(session.title)")
    }

    @objc private func profileButtonTapped() {
        let profileVC = ProfileViewController(dataSource: dataSource)
        navigationController?.pushViewController(profileVC, animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let session = sessions[indexPath.item]

        if useAccessibleCells {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccessibleSessionCell", for: indexPath) as! AccessibleSessionCell
            cell.configure(with: session)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SessionCell", for: indexPath) as! SessionCollectionViewCell
            cell.configure(with: session)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 15, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSession = sessions[indexPath.item]
        let detailsVC = SessionDetailsViewController()
        detailsVC.configure(with: selectedSession)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

