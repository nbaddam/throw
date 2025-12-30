//
//  ScrollViewController.swift
//  throw
//
//  Created by Nitya Baddam on 12/26/25.
//
// https://medium.com/@dkw5877/container-view-controllers-revisited-e076ef38853f

import UIKit

class ScrollViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func loadView() {
        
    }
    
    func setupViews() {
        
    }
}
