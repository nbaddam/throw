//
//  SessionCollectionViewCell.swift
//  throw
//
//  Created by Nitya Baddam on 11/17/25.
//

import UIKit

class SessionCollectionViewCell: UICollectionViewCell {
    let padding: CGFloat = 18
    
    let rightImageView = RightImageView()
    let leftSummaryView = LeftSummaryView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        self.backgroundColor = UIColor.secondarySystemBackground
        self.layer.cornerRadius = 16
        
        // setup chadow under cell
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
        
    func configure(with session: Session) {
        leftSummaryView.configure(title: session.title, date: session.date.formattedForDisplay(), sessionTypes: session.types)
        rightImageView.configure(images: session.images)
    }
}
