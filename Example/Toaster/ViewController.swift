//
//  ViewController.swift
//  Toaster
//
//  Created by Joan Disho on 27.05.19.
//  Copyright © 2019 disho. All rights reserved.
//

import UIKit
import JDToaster

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let shortToastButton = UIButton(type: .system)
        shortToastButton.setTitle("Short", for: .normal)
        shortToastButton.addTarget(self, action: #selector(showShortToaster), for: .primaryActionTriggered)


        let bigToastButton = UIButton(type: .system)
        bigToastButton.setTitle("Big", for: .normal)
        bigToastButton.addTarget(self, action: #selector(showBigToaster), for: .primaryActionTriggered)

        let hugeToastButton = UIButton(type: .system)
        hugeToastButton.setTitle("Huge", for: .normal)
        hugeToastButton.addTarget(self, action: #selector(showHugeToaster), for: .primaryActionTriggered)

        let dismissToastButton = UIButton(type: .system)
        dismissToastButton.setTitle("Dismiss", for: .normal)
        dismissToastButton.addTarget(self, action: #selector(dismissToaster), for: .primaryActionTriggered)

        let stackView = UIStackView(arrangedSubviews: [shortToastButton, bigToastButton, hugeToastButton, dismissToastButton])
        stackView.axis = .vertical
        stackView.spacing = 16.0

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc private func showShortToaster() {
        Toast.default.show(text: "Hello Toast!", duration: 4.0)
    }

    @objc private func showBigToaster() {
        Toast.default.show(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", duration: 4.0)
    }

    @objc private func showHugeToaster() {
        Toast.default.show(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", duration: 4.0)
    }

    @objc private func dismissToaster() {
        Toast.default.dismiss(animated: true)
    }
}
