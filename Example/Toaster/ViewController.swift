//
//  ViewController.swift
//  Toaster
//
//  Created by Joan Disho on 27.05.19.
//  Copyright © 2019 disho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let shortToastButton = UIButton(type: .system)
        shortToastButton.setTitle("Present", for: .normal)
        shortToastButton.addTarget(self, action: #selector(showToaster), for: .primaryActionTriggered)

        view.addSubview(shortToastButton)
        shortToastButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shortToastButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shortToastButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc private func showToaster() {
        Toaster.shared.show(
            text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            duration: 5.0
        )
    }
}

class ToasterPresentationController: UIPresentationController {

    var bottomPadding: CGFloat = 0.0
    var minimumHorizontalPadding: CGFloat = 0.0

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        guard let presentedView = presentedView else { return .zero }

        containerView.isUserInteractionEnabled = false

        let safeAreaFrame = containerView.bounds.inset(by: containerView.safeAreaInsets)

        let requiredFullWidthTargetSize = presentedView.systemLayoutSizeFitting(
            CGSize(width: safeAreaFrame.width - 2 * minimumHorizontalPadding, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )

        let defaultLowMinimumWidthTargetSize = presentedView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize,
            withHorizontalFittingPriority: .defaultLow,
            verticalFittingPriority: .defaultLow
        )

        var frame = safeAreaFrame

        frame.origin.y += frame.size.height - requiredFullWidthTargetSize.height - bottomPadding

        if defaultLowMinimumWidthTargetSize.width > safeAreaFrame.width - 2 * minimumHorizontalPadding {
            frame.origin.x += minimumHorizontalPadding
            frame.size.width = requiredFullWidthTargetSize.width
        } else {
            frame.origin.x += (frame.size.width - defaultLowMinimumWidthTargetSize.width) / 2
            frame.size.width = defaultLowMinimumWidthTargetSize.width
        }

        frame.size.height = requiredFullWidthTargetSize.height

        return frame
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}

class ToasterViewController: UIViewController, UIViewControllerTransitioningDelegate {

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
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: configuration.textInsets.top),
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
        let toasterPresentationController = ToasterPresentationController(presentedViewController: presented, presenting: presenting)
        toasterPresentationController.bottomPadding = configuration.bottomPadding
        toasterPresentationController.minimumHorizontalPadding = configuration.minimumHorizontalPadding
        return toasterPresentationController
    }
}

class Toaster {
    var backgroundColor: UIColor = .black
    var font: UIFont = .systemFont(ofSize: 17, weight: .medium)
    var textColor: UIColor = .white
    var textInsets: UIEdgeInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    var cornerRadius: CGFloat = 8.0
    var bottomPadding: CGFloat = 16.0
    var minimumHorizontalPadding: CGFloat = 24.0

    static let `default` = Toaster()

    func show(text: String, duration: Double) {
        dismiss(animated: true)

        let toaster = ToasterViewController(
            configuration: ToasterViewController.Configuration(
                text: text,
                backgroundColor: backgroundColor,
                font: font,
                textColor: textColor,
                textInsets: textInsets,
                cornerRadius: cornerRadius,
                bottomPadding: bottomPadding,
                minimumHorizontalPadding: minimumHorizontalPadding
            )
        )

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.isUserInteractionEnabled = false

        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear

        window.rootViewController = viewController
        window.windowLevel = UIWindow.Level.normal + 1
        window.makeKeyAndVisible()

        viewController.present(toaster, animated: true, completion: nil)

        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            toaster.dismiss(animated: true, completion: nil)
        }
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootViewController.dismiss(animated: animated, completion: completion)
    }
}

extension UIViewController {
    var topMostChild: UIViewController? {
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostChild
        } else if let nav = self as? UINavigationController {
            return nav.topViewController?.topMostChild
        } else if let split = self as? UISplitViewController {
            return split.viewControllers.last?.topMostChild
        } else if let presented = presentedViewController {
            return presented.topMostChild
        }
        return self
    }
}

extension CALayer {
    func roundCorners(_ corners: UIRectCorner = .allCorners, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.mask = mask
    }
}


class PresentToasterAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        transitionContext.containerView.addSubview(toView)

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            toView.frame.origin = CGPoint(x: toView.frame.origin.x, y: toView.frame.height)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

class DismissToasterAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            fromView.frame.origin = CGPoint(x: fromView.frame.origin.x, y: -fromView.frame.height)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
