//
//  Toast.swift
//  JDToaster
//
//  Created by Joan Disho on 12.06.19.
//  Copyright © 2019 disho. All rights reserved.
//

import Foundation
import UIKit

public final class Toast {
    public var backgroundColor: UIColor = .black
    public var font: UIFont = .systemFont(ofSize: 17, weight: .medium)
    public var textColor: UIColor = .white
    public var textInsets: UIEdgeInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    public var cornerRadius: CGFloat = 8.0
    public var bottomPadding: CGFloat = 16.0
    public var minimumHorizontalPadding: CGFloat = 24.0

    public static let `default` = Toast()

    private var window: UIWindow?
    private var timer: Timer? {
        willSet {
            timer?.invalidate()
        }
    }

    public func show(text: String, duration: Double, animated: Bool = true) {
        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
            self?.dismiss(animated: animated)
        }

        let toaster = ToastViewController(
            configuration: ToastViewController.Configuration(
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

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.isUserInteractionEnabled = false

        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear

        window?.rootViewController = viewController
        window?.windowLevel = UIWindow.Level.normal + 1
        window?.makeKeyAndVisible()

        viewController.present(toaster, animated: animated, completion: nil)
    }

    public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .first(where: { $0.isKeyWindow })

        guard let rootViewController = keyWindow?.rootViewController else { return }
        rootViewController.dismiss(animated: animated, completion: completion)
    }
}
