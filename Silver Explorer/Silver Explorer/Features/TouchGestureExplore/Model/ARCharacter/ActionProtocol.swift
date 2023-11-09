//
//  Action.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 11/9/23.
//

import UIKit

@objc protocol ActionProtocol {
    @objc func jump()
    @objc func highJump(_ gesture: UILongPressGestureRecognizer)
    @objc func rightAngleRotate(_ gesture: UISwipeGestureRecognizer)
    @objc func eulerAngleRotate(_ gesture: UIPanGestureRecognizer)
    @objc func scaleUpAndDown(_ gesture: UIPinchGestureRecognizer)
    @objc func zAxisRotate(_ gesture: UIRotationGestureRecognizer)
}
