//
//  ExpandableViewController.swift
//  ExpandableComponents
//
//  Created by Edwin Cardenas on 9/1/25.
//

import UIKit

class ExpandableViewController: UIViewController {

    // MARK: - Properties

    let firstView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemTeal
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true

        return view
    }()

    lazy var expandibleView: ExpandableView = {
        let expandableView = ExpandableView()

        expandableView.delegate = self

        return expandableView
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

}

// MARK: - Helpers

extension ExpandableViewController {

    private func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(firstView)
        view.addSubview(expandibleView)

        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            firstView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 10
            ),
            firstView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -10
            ),
        ])

        NSLayoutConstraint.activate([
            expandibleView.topAnchor.constraint(equalTo: firstView.bottomAnchor),
            expandibleView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
            expandibleView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor)
        ])
    }

}

// MARK: - ExpandableViewComponentDelegate

extension ExpandableViewController: ExpandableViewComponentDelegate {

    func didViewDidLayoutSuperview() {
        UIView.animate(withDuration: 0.5) {
            self.view.layoutSubviews()
        }
    }

}
