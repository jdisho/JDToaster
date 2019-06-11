//
//  Toaster.swift
//  JDToaster
//
//  Created by Joan Disho on 11.06.19.
//  Copyright © 2019 disho. All rights reserved.
//

import Foundation
import UIKit

public final class Toaster {
    public var backgroundColor: UIColor = .black
    public var font: UIFont = .systemFont(ofSize: 17, weight: .medium)
    public var textColor: UIColor = .white
    public var textInsets: UIEdgeInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    public var cornerRadius: CGFloat = 8.0
    public var bottomPadding: CGFloat = 16.0
    public var minimumHorizontalPadding: CGFloat = 24.0

    public static let `default` = Toaster()

    public func show(text: String, duration: Double) {
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
    }

    public func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootViewController.dismiss(animated: animated, completion: completion)
    }
}
