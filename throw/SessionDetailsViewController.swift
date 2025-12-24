//
//  SessionDetailsViewController.swift
//  throw
//
//  Created by Nitya Baddam on 11/17/25.
//

import UIKit
import Foundation

class SessionDetailsViewController: UIViewController {
    
    var session: Session!
    
    let padding: CGFloat = 20
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageCarousel: CarouselView = {
        let c = CarouselView()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(imageCarousel)
        imageCarousel.scrollView.delegate = self
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            imageCarousel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            imageCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            imageCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            imageCarousel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -padding*2),
            imageCarousel.heightAnchor.constraint(equalTo: imageCarousel.widthAnchor)
        ])
        
        let items = createCarouselItems(with: session.images ?? [])
        imageCarousel.setItems(items)
    }
    
    func configure(with session: Session) {
        self.session = session
        titleLabel.text = session.title
    }
    
    func createCarouselItems(with images: [UIImage]) -> [UIImageView] {
        var items: [UIImageView] = []

        for i in images {
            let imageView = UIImageView()
            imageView.image = i.squared
            
            // by default, images in UIKit are decorative
            // make it an accessibility element and add a label - ideally users are able to add this label themselves, or VO/AI can help us generate temporary labels
            imageView.isAccessibilityElement = true
            imageView.accessibilityLabel = "Session: \(session.title). Image \(i) of \(images.count)."
            
            imageView.contentMode = .scaleAspectFit
            items.append(imageView)
        }

        return items
    }
}

extension SessionDetailsViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        imageCarousel.pageControl.currentPage = pageIndex
    }
}

