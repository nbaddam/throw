//
//  SessionCell.swift
//  throw
//
//  Created by Nitya Baddam on 11/17/25.
//

import UIKit

class SessionCell: UICollectionViewCell {
    let padding: CGFloat = 18
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 4.0
        imageView.layer.cornerRadius = 16
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 16
        
        // setup chadow under cell
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
    }
    
    func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(leftSummaryView)
        
        NSLayoutConstraint.activate([
            leftSummaryView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            leftSummaryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            leftSummaryView.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -padding),
            
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        let rotationAngle: CGFloat = 5 * .pi / 180
        imageView.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }
        
    func configure(with session: Session) {
        leftSummaryView.configure(title: session.title, date: session.date.formattedForDisplay(), sessionTypes: session.types)
        
        imageView.image = session.image?.squared
    }
}
