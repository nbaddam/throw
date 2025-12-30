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
    
    lazy var detailView = PostDetailView()
    
    lazy var imageCarousel: CarouselView = {
        let c = CarouselView()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(detailView)
        view.addSubview(imageCarousel)
        view.backgroundColor = .systemBackground
        imageCarousel.scrollView.delegate = self
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            imageCarousel.topAnchor.constraint(equalTo: detailView.bottomAnchor, constant: padding),
            imageCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            imageCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            imageCarousel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -padding*2),
            imageCarousel.heightAnchor.constraint(equalTo: imageCarousel.widthAnchor)
        ])
        
        // needs to happen at this point otherwise it could try to unwrap a nil object
        let items = createCarouselItems(with: session.images)
        self.imageCarousel.setItems(items)
    }
    
    func configure(with session: Session) {
        self.session = session
        self.detailView.configure(title: session.title, date: session.date.formattedForDisplay(), sessionTypes: session.types)
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

