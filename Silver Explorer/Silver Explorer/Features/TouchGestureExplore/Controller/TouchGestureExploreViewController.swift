//
//  TouchGestureExploreViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/26.
//

import UIKit
import SceneKit
import ARKit

class TouchGestureExploreViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet private var sceneView: ARSCNView!
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var informationBlurView: UIVisualEffectView!
    @IBOutlet weak var informationBackgroundView: UIView!
    
    @IBOutlet private weak var stageTitleLabel: UILabel!
    @IBOutlet private weak var stageDescriptionView: UIVisualEffectView!
    @IBOutlet private weak var stageDescriptionLabel: UILabel!
    @IBOutlet private weak var stageImageView: UIImageView!
    @IBOutlet private weak var touchGestureStageView: UIView!

    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var previousBtnView: UIView!
    @IBOutlet private weak var nextBtnView: UIView!

    private var gestureRecognizers: [UIGestureRecognizer] = []
    private var stage: Stage.StageType = .shortTap
    
    weak var arCharacterDelegate: ARCharacterDelegate?
    private var arCharacter: ARCharacter!

    
    // MARK: - View LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        touchGestureStageView.isHidden = true
        
        setARCharacter()
        applyRoundedCornersToViews()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }

}

extension TouchGestureExploreViewController {
    
    // MARK: - viewDidLoad 로직 모듈화 메서드
    
    private func setARCharacter() {
        guard let character = arCharacterDelegate?.selectedARCharacter() else {
            return
        }
        self.arCharacter = character
        self.arCharacter.setSceneView(sceneView: sceneView)
    }
    
    private func applyRoundedCornersToViews() {
        makeCornerRoundShape(targetView: informationBackgroundView, cornerRadius: 40)
        makeCornerRoundShape(targetView: informationBlurView, cornerRadius: 40)
        makeCornerRoundShape(targetView: titleView, cornerRadius: 10)
        makeCornerRoundShape(targetView: previousBtnView, cornerRadius: 10)
        makeCornerRoundShape(targetView: nextBtnView, cornerRadius: 10)
        makeCornerRoundShape(targetView: stageDescriptionView, cornerRadius: 40)
    }
    
    // MARK: - ARKit & SceneKit 관련 메서드
   
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        if let _ = anchor as? ARImageAnchor {
            readyForUIGestureExplore()
            return arCharacter.characterContainerNode
        }
        
        return nil
   }
    
    private func beginARSession() {
        let configuration = ARImageTrackingConfiguration()
        
        guard let trackingImage = ARReferenceImage.referenceImages(inGroupNamed: "Explore Ticket", bundle: Bundle.main) else {
            return
        }
        
        configuration.trackingImages = trackingImage
        configuration.maximumNumberOfTrackedImages = 1

        sceneView.session.run(configuration)
    }

    // MARK: - IBAction Methods
    
    @IBAction private func moveNextStage(_ sender: UIButton) {
        if (stage == .rotate) {
            self.navigationController?.popViewController(animated: true)
        } else {
            resetARCharacter()
            changeStage(isNext: true)
            stageTitleLabel.text = TouchGestureExploreModel.stageTitles[stage.rawValue]
        }
    }

    @IBAction private func moveBackStage(_ sender: UIButton) {
        if (stage == .shortTap) {
            self.navigationController?.popViewController(animated: true)
        } else {
            resetARCharacter()
            changeStage(isNext: false)
            stageTitleLabel.text = TouchGestureExploreModel.stageTitles[stage.rawValue]
        }
    }
    
    @IBAction private func informationViewTouched(_ sender: UITapGestureRecognizer) {
        self.informationView.isHidden = true
        beginARSession()
    }
    
    @IBAction private func stageDescriptionViewTouched(_ sender: UITapGestureRecognizer) {
        self.stageDescriptionView.isHidden = true
    }
    
    
    // MARK: - Feature Methods
    
    private func resetARCharacter() {
        if (stage == .swipe || stage == .rotate) {
            if (arCharacter is Finn) {
                let finnBodyNode = (arCharacter as! Finn).bodyNode
                arCharacter.resetARCharacterAngle(targetNode: finnBodyNode)
            } else {
                arCharacter.resetARCharacterAngle(targetNode: arCharacter.characterNode)
            }
        } else if (stage == .pinch) {
            arCharacter.resetARCharacterScale()
        }
    }

    private func changeStage(isNext: Bool) {
        Stage.changeStage(&stage, isNext)
        addNewGestureRecognizer(stage, arCharacter)

        stageImageView.image = TouchGestureExploreModel.stageImages[self.stage]
        stageDescriptionLabel.text = TouchGestureExploreModel.stageDescriptions[self.stage]
        stageDescriptionView.isHidden = false
    }
    
    private func addNewGestureRecognizer(_ stage: Stage.StageType, _ arCharacter: ARCharacter) {
        if (!gestureRecognizers.isEmpty) {
            gestureRecognizers.forEach { touchGestureStageView.removeGestureRecognizer($0) }
            gestureRecognizers.removeAll()
        }
        
        gestureRecognizers = GestureRecongizerForCharcater.createGestureRecognizer(target: arCharacter, stage)
        gestureRecognizers.forEach { touchGestureStageView.addGestureRecognizer($0) }
    }
    
    private func readyForUIGestureExplore() {
        DispatchQueue.main.async {
            self.touchGestureStageView.isHidden = false
            self.touchGestureStageView.alpha = 0.0
            
            self.addNewGestureRecognizer(self.stage, self.arCharacter)

            UIView.animate(withDuration: 1.0, delay: 2.0, options: .curveEaseInOut, animations: {
                self.touchGestureStageView.alpha = 1.0
            })
        }
    }
}
