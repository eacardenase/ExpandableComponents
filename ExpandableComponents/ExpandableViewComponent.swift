//
//  ExpandableViewComponent.swift
//  ExpandableComponents
//
//  Created by Edwin Cardenas on 9/1/25.
//

import UIKit

protocol ExpandableViewComponentDelegate: AnyObject {

    func didViewDidLayoutSuperview()

}

class ExpandableViewComponent: UIView {

    // MARK: - Properties

    weak var delegate: ExpandableViewComponentDelegate?

    let label: UILabel = {
        let _label = UILabel()

        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.text = "Label"

        return _label
    }()

    var buttonTitle: String? {
        didSet {
            showMoreButton.setTitle(buttonTitle, for: .normal)
        }
    }

    lazy var showMoreButton: UIButton = {
        let button = UIButton(type: .system)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show More", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )

        return button
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension ExpandableViewComponent {

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemIndigo

        addSubview(label)
        addSubview(showMoreButton)

        // label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            label.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])

        // showMoreButton
        NSLayoutConstraint.activate([
            showMoreButton.centerYAnchor.constraint(
                equalTo: label.centerYAnchor
            ),
            showMoreButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
        ])
    }

}

// MARK: - Actions

extension ExpandableViewComponent {

    @objc func buttonTapped(_ sender: UIButton) {
        delegate?.didViewDidLayoutSuperview()
    }

}
