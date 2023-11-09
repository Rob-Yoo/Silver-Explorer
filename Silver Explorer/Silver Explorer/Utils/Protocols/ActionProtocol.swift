//
//  Action.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 11/9/23.
//

import UIKit

@objc protocol ActionProtocol {
    @objc optional func jump()
    @objc optional func highJump(_ gesture: UILongPressGestureRecognizer)
    @objc optional func rightAngleRotate(_ gesture: UISwipeGestureRecognizer)
    @objc optional func eulerAngleRotate(_ gesture: UIPanGestureRecognizer)
    @objc optional func scaleUpAndDown(_ gesture: UIPinchGestureRecognizer)
    @objc optional func zAxisRotate(_ gesture: UIRotationGestureRecognizer)
}
