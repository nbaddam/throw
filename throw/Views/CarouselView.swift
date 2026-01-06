//
//  CarouselView.swift
//  throw
//
//  Created by Nitya Baddam on 12/11/25.
//

import UIKit

class CarouselView: UIView {
    // Array of views to be displayed in the carousel
    private var itemViews: [UIImageView] = []
    let padding: CGFloat = 20
    
    // Scroll view to enable horizontal scrolling
    internal let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    internal let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        return pageControl
    }()
    
    // Initializer for the view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // Initial setup of the view
    private func setupView() {
        addSubview(scrollView)
//        addSubview(pageControl)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        pageControl.addTarget(pageControl, action: #selector(pageControlTapped(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
//            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: padding),
//            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
//            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // Method to add views to the carousel
    func setItems(_ views: [UIImageView]) {
        itemViews.forEach { $0.removeFromSuperview() } // Remove previous views
        itemViews = views
        setupItems()
    }
    
    // Setup and position the views within the scroll view
    private func setupItems() {
        var previousView: UIImageView? = nil
        
        for view in itemViews {
            pageControl.numberOfPages += 1
            scrollView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: scrollView.topAnchor),
                view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                view.widthAnchor.constraint(equalTo: widthAnchor),
                view.heightAnchor.constraint(equalTo: widthAnchor)
            ])
            
            if let previous = previousView {
                view.leadingAnchor.constraint(equalTo: previous.trailingAnchor).isActive = true
            } else {
                view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            }
            
            previousView = view
        }
        
        if let lastView = previousView {
            lastView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        }
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        let xOffset = CGFloat(currentPage) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
}
