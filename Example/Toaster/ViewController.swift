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
        shortToastButton.setTitle("Show Toaster", for: .normal)
        shortToastButton.addTarget(self, action: #selector(showToaster), for: .primaryActionTriggered)

        view.addSubview(shortToastButton)
        shortToastButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shortToastButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shortToastButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc private func showToaster() {
       // Show Toaster
    }
}
