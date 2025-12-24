//
//  ViewController.swift
//  throw
//
//  Created by Nitya Baddam on 11/15/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    var collectionView: UICollectionView!
    let sessions: [Session] = {
        let currentDateTime = Date()
        let week = 604800.00
        let myImages = [UIImage(named: "First_Cup_Thrown")!, UIImage(named: "First_Vase_Thrown")!]
        
        var s = [
            Session(title: "First class", date: Date(timeInterval: -(week*2), since: currentDateTime), types: [.throwing, .trimming, .glazing, .firing, .handbuilding], body: "Today I had my first class and we learned how to center clay!", images: myImages),
            Session(title: "Second throwing attempt", date: Date(timeInterval: -week, since: currentDateTime), types: [.throwing], images: myImages),
            Session(title: "The time I realized the importance of centering", date: Date(timeInterval: -week, since: currentDateTime), types: [.trimming], images: myImages),
            Session(title: "Trimming extravanganza!", date: currentDateTime, types: [.trimming], images: myImages)
        ]
        
        return s
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "Home"
        view.backgroundColor = .systemBackground
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SessionCell.self, forCellWithReuseIdentifier: "SessionCell")
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
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SessionCell", for: indexPath) as! SessionCell
        let session = sessions[indexPath.item]
        cell.configure(with: session)
        
        return cell
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

