//
//  RightImageView.swift
//  throw
//
//  Created by Nitya Baddam on 12/13/25.
//

import UIKit

class RightImageView: UIView {
    
    private var hasMultipleImages: Bool = false
    
//    lazy var imageStackView: UIStackView = {
//        let s = UIStackView()
//        s.translatesAutoresizingMaskIntoConstraints = false
//        s.axis = .vertical
//        s.distribution = .fillProportionally
//        return s
//    }()
    
    lazy var imageView: UIImageView = {
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
    
    lazy var secondImageView: UIImageView = {
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
        
        setupSecondImageView()
        setupFirstImageView()
    }
    
    private func setupFirstImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        updateRotationAngle()
    }
    
    private func setupSecondImageView() {
        addSubview(secondImageView)
        
        NSLayoutConstraint.activate([
            secondImageView.topAnchor.constraint(equalTo: topAnchor),
            secondImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            secondImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func updateRotationAngle(tilt: Bool = true) {
        var rotationAngle: CGFloat = 8 * .pi / 180
        
        if !tilt {
            rotationAngle = 0
        }
        
        imageView.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }
    
    
    func configure(images: [UIImage]) {
        imageView.image = images[0].squared
        
        if images.count > 1 {
            secondImageView.image = images[1].squared
        } else {
            secondImageView.removeFromSuperview()
            updateRotationAngle(tilt: false)
        }
    }
}
