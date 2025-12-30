//
//  PostDetailView.swift
//  throw
//
//  Created by Nitya Baddam on 12/27/25.
//

import UIKit

class PostDetailView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var badgeScrollableView = BadgeScrollableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(badgeScrollableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            badgeScrollableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            badgeScrollableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            badgeScrollableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            badgeScrollableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(title: String, date: String, sessionTypes: [SessionType]) {
        titleLabel.text = title
        dateLabel.text = date
        badgeScrollableView.configure(sessionTypes: sessionTypes)
    }
}
