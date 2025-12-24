//
//  LeftSummaryView.swift
//  throw
//
//  Created by Nitya Baddam on 11/24/25.
//

import UIKit

class LeftSummaryView: UIView {
    
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
    
    lazy var badgeScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var badgeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
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
        addSubview(badgeScrollView)
        badgeScrollView.addSubview(badgeStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // !! when adding a stack view to a scroll view, constraints are important !!
            //
            // the two pieces that helped me get this working:
            // 1. I missed adding a bottom constraint to the scrollView and its content didn't scroll until I did
            // 2. then, making sure the stackView's constraints exactly matched the scrollView was the next piece
            //
            // the pieces that I tried changing but didn't matter:
            // 1. the order of adding subViews
            // 2. the height/width constraints of the stackView
            // 3. the distribution, spacing, and alignment of the scrollView
            //
            badgeScrollView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            badgeScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            badgeScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            badgeScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            badgeScrollView.heightAnchor.constraint(equalToConstant: 28),
            
            badgeStackView.topAnchor.constraint(equalTo: badgeScrollView.topAnchor),
            badgeStackView.leadingAnchor.constraint(equalTo: badgeScrollView.leadingAnchor),
            badgeStackView.trailingAnchor.constraint(equalTo: badgeScrollView.trailingAnchor),
            badgeStackView.bottomAnchor.constraint(equalTo: badgeScrollView.bottomAnchor),
        ])
    }
    
    func configure(title: String, date: String, sessionTypes: [SessionType]) {
        titleLabel.text = title
        dateLabel.text = date
        
        // clear out badges before adding
        badgeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        sessionTypes.forEach { type in
            let badge = SessionTypeBadgeView()
            badge.configure(with: type)
            badgeStackView.addArrangedSubview(badge)
        }
        
    }
}
