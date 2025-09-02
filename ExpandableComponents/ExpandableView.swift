//
//  ExpandableView.swift
//  ExpandableComponents
//
//  Created by Edwin Cardenas on 9/1/25.
//

import UIKit

class ExpandableView: UIView {

    // MARK: - Properties

    weak var delegate: ExpandableViewComponentDelegate?

    private var shouldCollapse = true

    var buttonTitle: String {
        return shouldCollapse ? "Show More" : "Show Less"
    }

    lazy var primaryView: ExpandableViewComponent = {
        let component = ExpandableViewComponent()

        component.delegate = self

        return component
    }()

    let secondaryView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink

        return view
    }()

    let tertiaryView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGreen

        return view
    }()

    let expandableView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow

        return view
    }()

    var expandableViewHeightConstraint = NSLayoutConstraint()

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

extension ExpandableView {

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(primaryView)
        addSubview(secondaryView)
        addSubview(expandableView)
        addSubview(tertiaryView)

        // primaryView
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(
                equalTo: topAnchor,
            ),
            primaryView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            primaryView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
        ])

        // secondaryView
        NSLayoutConstraint.activate([
            secondaryView.topAnchor.constraint(
                equalTo: primaryView.bottomAnchor
            ),
            secondaryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondaryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondaryView.heightAnchor.constraint(equalToConstant: 50),
        ])

        // expandableView
        expandableViewHeightConstraint = expandableView.heightAnchor.constraint(
            equalToConstant: 0
        )

        NSLayoutConstraint.activate([
            expandableView.topAnchor.constraint(
                equalTo: secondaryView.bottomAnchor
            ),
            expandableView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            expandableView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            expandableViewHeightConstraint,
        ])

        // tertiaryView
        NSLayoutConstraint.activate([
            tertiaryView.topAnchor.constraint(
                equalTo: expandableView.bottomAnchor
            ),
            tertiaryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tertiaryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tertiaryView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tertiaryView.heightAnchor.constraint(equalToConstant: 60),
        ])

    }

}

// MARK: - ExpandableViewComponentDelegate

extension ExpandableView: ExpandableViewComponentDelegate {

    func didViewDidLayoutSuperview() {
        UIView.animate(withDuration: 0.3) {
            self.shouldCollapse.toggle()

            self.primaryView.buttonTitle = self.buttonTitle
            self.expandableViewHeightConstraint.constant =
                self.shouldCollapse ? 0 : 100

            self.delegate?.didViewDidLayoutSuperview()

            self.layoutIfNeeded()
        }
    }

}
