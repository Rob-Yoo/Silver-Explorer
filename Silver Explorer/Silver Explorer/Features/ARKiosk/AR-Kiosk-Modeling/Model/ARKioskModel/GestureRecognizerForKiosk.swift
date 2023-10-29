//
//  ARKioskExplore.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/14.
//

import UIKit
import ARKit
import SceneKit

struct GestureRecognizerForKiosk {
    
    static func createSwipeAndPinchGestureRecognizer(_ arKiosk: ARKioskModel) -> [UIGestureRecognizer] {
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: arKiosk, action: #selector(arKiosk.rightAngleRotate))
        let rightSwipeGesture = UISwipeGestureRecognizer(target: arKiosk, action: #selector(arKiosk.rightAngleRotate))
        let pinchGesture = UIPinchGestureRecognizer(target: arKiosk, action: #selector(arKiosk.scaleUpAndDown))
        
        leftSwipeGesture.direction = .left
        rightSwipeGesture.direction = .right
        
        return [pinchGesture, leftSwipeGesture, rightSwipeGesture]
    }
}
