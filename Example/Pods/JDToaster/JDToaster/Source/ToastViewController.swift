//
//  ToastViewController.swift
//  JDToaster
//
//  Created by Joan Disho on 12.06.19.
//  Copyright © 2019 disho. All rights reserved.
//

import Foundation
import UIKit

final class ToastViewController: UIViewController, UIViewControllerTransitioningDelegate {
    struct Configuration {
        let text: String
        let backgroundColor: UIColor
        let font: UIFont
        let textColor: UIColor
        let textInsets: UIEdgeInsets
        let cornerRadius: CGFloat
        let bottomPadding: CGFloat
        let minimumHorizontalPadding: CGFloat
    }

    private let configuration: Configuration

    private var cornerRadius: CGFloat {
        didSet {
            view.layoutSubviews()
        }
    }

    init(configuration: Configuration) {
        self.configuration = configuration
        cornerRadius = configuration.cornerRadius

        super.init(nibName: nil, bundle: nil)

        transitioningDelegate = self
        modalPresentationStyle = .custom

        view.backgroundColor = configuration.backgroundColor

        let label = UILabel()
        label.font = configuration.font
        label.textColor = configuration.textColor
        label.text = configuration.text
        label.numberOfLines = 0

        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(
                equalTo: view.topAnchor, constant: configuration.textInsets.top),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -configuration.textInsets.bottom),
            label.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -(configuration.textInsets.left + configuration.textInsets.right)),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        view.layer.roundCorners(radius: cornerRadius)
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let toastPresentationController = ToastPresentationController(presentedViewController: presented, presenting: presenting)
        toastPresentationController.bottomPadding = configuration.bottomPadding
        toastPresentationController.minimumHorizontalPadding = configuration.minimumHorizontalPadding
        return toastPresentationController
    }
}

private extension CALayer {
    func roundCorners(_ corners: UIRectCorner = .allCorners, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.mask = mask
    }
}
