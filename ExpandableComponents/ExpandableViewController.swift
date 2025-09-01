//
//  ExpandableViewController.swift
//  ExpandableComponents
//
//  Created by Edwin Cardenas on 9/1/25.
//

import UIKit

class ExpandableViewController: UIViewController {

    // MARK: - Properties

    lazy var firstView: ExpandableView = {
        let expandableView = ExpandableView()

        expandableView.delegate = self

        return expandableView
    }()

    lazy var secondView: ExpandableView = {
        let expandableView = ExpandableView()

        expandableView.delegate = self

        return expandableView
    }()

    lazy var thirdView: ExpandableView = {
        let expandableView = ExpandableView()

        expandableView.delegate = self

        return expandableView
    }()

    let stackView: UIStackView = {
        let _stackView = UIStackView()

        _stackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.axis = .vertical
        _stackView.spacing = 6

        return _stackView
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

        stackView.addArrangedSubview(firstView)
        stackView.addArrangedSubview(secondView)
        stackView.addArrangedSubview(thirdView)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 10
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -10
            ),
        ])
    }

}

// MARK: - ExpandableViewComponentDelegate

extension ExpandableViewController: ExpandableViewComponentDelegate {

    func didViewDidLayoutSuperview() {
        UIView.animate(withDuration: 0.5) {
            self.stackView.layoutSubviews()
        }
    }

}
