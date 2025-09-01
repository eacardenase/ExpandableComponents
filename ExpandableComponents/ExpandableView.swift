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

    lazy var expandableViewComponent: ExpandableViewComponent = {
        let component = ExpandableViewComponent()

        component.delegate = self

        return component
    }()

    let secondView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow

        return view
    }()

    var secondViewHeightConstraint = NSLayoutConstraint()

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

        addSubview(expandableViewComponent)
        addSubview(secondView)

        NSLayoutConstraint.activate([
            expandableViewComponent.topAnchor.constraint(equalTo: topAnchor),
            expandableViewComponent.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            expandableViewComponent.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
        ])

        secondViewHeightConstraint = secondView.heightAnchor.constraint(
            equalToConstant: 0
        )

        NSLayoutConstraint.activate([
            secondView.topAnchor.constraint(
                equalTo: expandableViewComponent.bottomAnchor
            ),
            secondView.leadingAnchor.constraint(
                equalTo: expandableViewComponent.leadingAnchor
            ),
            secondView.trailingAnchor.constraint(
                equalTo: expandableViewComponent.trailingAnchor
            ),
            secondView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            secondViewHeightConstraint,
        ])
    }

}

// MARK: - ExpandableViewComponentDelegate

extension ExpandableView: ExpandableViewComponentDelegate {

    func didViewDidLayoutSuperview() {
        UIView.animate(withDuration: 0.3) {
            self.shouldCollapse.toggle()

            self.expandableViewComponent.buttonTitle = self.buttonTitle
            self.secondViewHeightConstraint.constant =
                self.shouldCollapse ? 0 : 100

            self.delegate?.didViewDidLayoutSuperview()

            self.layoutIfNeeded()
        }
    }

}
