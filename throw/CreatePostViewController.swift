//
//  CreatePostViewController.swift
//  throw
//
//  Created by Nitya Baddam on 11/16/25.
//

import UIKit

class CreatePostViewController: UIViewController {

    // DEMO TOGGLE: Change this boolean to switch between implementations
    // true = Accessible form with labels, hints, and announcements
    // false = Non-accessible form with common mistakes
    private let useAccessibleForm = true

    private var formView: UIView!
    private var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupScrollView()
        setupForm()
    }

    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupForm() {
        if useAccessibleForm {
            // Use accessible form implementation
            let accessibleForm = AccessibleSessionForm()
            accessibleForm.translatesAutoresizingMaskIntoConstraints = false
            accessibleForm.saveButton.addTarget(self, action: #selector(handleSaveAccessible), for: .touchUpInside)
            formView = accessibleForm
        } else {
            // Use non-accessible form implementation
            let nonAccessibleForm = NonAccessibleSessionForm()
            nonAccessibleForm.translatesAutoresizingMaskIntoConstraints = false
            nonAccessibleForm.saveButton.addTarget(self, action: #selector(handleSaveNonAccessible), for: .touchUpInside)
            formView = nonAccessibleForm
        }

        scrollView.addSubview(formView)

        NSLayoutConstraint.activate([
            formView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            formView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            formView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            formView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    @objc private func handleSaveAccessible() {
        guard let form = formView as? AccessibleSessionForm else { return }

        if form.validateForm() {
            form.announceSuccess()
            // In a real app, would save the session here
            print("Saving accessible form...")
        }
    }

    @objc private func handleSaveNonAccessible() {
        guard let form = formView as? NonAccessibleSessionForm else { return }

        if form.validateForm() {
            // Non-accessible version has no success announcement
            print("Saving non-accessible form...")
        }
    }
}
