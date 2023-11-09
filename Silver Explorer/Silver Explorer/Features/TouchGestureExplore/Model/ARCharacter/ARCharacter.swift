//
//  ARCharacter.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/26.
//

import ARKit
import SceneKit

class ARCharacter: ActionProtocol {
    var sceneView: ARSCNView!
    var characterContainerNode: SCNNode
    var characterNode: SCNNode
    var eulerAngleOfCharacterNode: SCNVector3
    var longPressStartTime: CFTimeInterval = 0.0
    var initialScale: CGFloat

    init(characterContainerNode: SCNNode, characterNodeName: String) {
        self.characterContainerNode = characterContainerNode
        self.characterNode = characterContainerNode.childNode(withName: characterNodeName, recursively: true)!
        self.eulerAngleOfCharacterNode = characterNode.eulerAngles
        self.initialScale = CGFloat(characterNode.scale.x)
    }
    
    // MARK: - Final Methods

    final func setSceneView(sceneView: ARSCNView) { self.sceneView = sceneView }
    
    final func resetARCharacterAngle(targetNode: SCNNode) {
        let resetAngleAction = SCNAction.rotateTo(x: CGFloat(eulerAngleOfCharacterNode.x), y: CGFloat(eulerAngleOfCharacterNode.y), z: CGFloat(eulerAngleOfCharacterNode.z), duration: 0.2)
        
        targetNode.runAction(resetAngleAction)
    }
    
    final func resetARCharacterScale() {
        let resetScaleAction = SCNAction.customAction(duration: 0.2) { (_, _) in
            self.characterNode.scale = SCNVector3(self.initialScale, self.initialScale, self.initialScale)
        }
        
        characterNode.runAction(resetScaleAction)
    }
    
    
    // MARK: - ActionProtocol Methods

    @objc func jump() { fatalError("ARCharacter 클래스의 Jump 함수는 무조건 오버라이드!!") }
    @objc func highJump(_ gesture: UILongPressGestureRecognizer) { fatalError("ARCharacter 클래스의 highJump 함수는 무조건 오버라이드!!") }
    @objc func rightAngleRotate(_ gesture: UISwipeGestureRecognizer) { fatalError("ARCharacter 클래스의 rightAngleRotate 함수는 무조건 오버라이드!!") }
    @objc func eulerAngleRotate(_ gesture: UIPanGestureRecognizer) { fatalError("ARCharacter 클래스의 eulerAngleRotate 함수는 무조건 오버라이드!!")}
    @objc func scaleUpAndDown(_ gesture: UIPinchGestureRecognizer) { fatalError("ARCharacter 클래스의 scaleUpAndDown 함수는 무조건 오버라이드!!") }
    @objc func zAxisRotate(_ gesture: UIRotationGestureRecognizer) { fatalError("ARCharacter 클래스의 zAxisRotate 함수는 무조건 오버라이드!!") }
}
