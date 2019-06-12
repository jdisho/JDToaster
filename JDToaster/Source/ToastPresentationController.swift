//
//  ToastPresentationController.swift
//  JDToaster
//
//  Created by Joan Disho on 12.06.19.
//  Copyright © 2019 disho. All rights reserved.
//

import Foundation
import UIKit

final class ToastPresentationController: UIPresentationController {

    var bottomPadding: CGFloat = 0.0
    var minimumHorizontalPadding: CGFloat = 0.0

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        guard let presentedView = presentedView else { return .zero }

        containerView.isUserInteractionEnabled = false

        let safeAreaFrame = containerView.bounds.inset(by: containerView.safeAreaInsets)

        let requiredFullWidthTargetSize = presentedView.systemLayoutSizeFitting(
            CGSize(
                width: safeAreaFrame.width - 2 * minimumHorizontalPadding,
                height: UIView.layoutFittingCompressedSize.height
            ),
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
