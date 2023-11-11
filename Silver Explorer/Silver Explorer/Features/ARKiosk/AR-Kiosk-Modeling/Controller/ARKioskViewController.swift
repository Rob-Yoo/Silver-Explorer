//
//  ViewController.swift
//  AR_Kiosk
//
//  Created by Jinyoung Yoo on 2023/07/23.
//

import UIKit
import SceneKit
import ARKit

class ARKioskViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var arExperienceButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var descriptionView: UIVisualEffectView!

    private var pokeNode : SCNNode?
    private var sceneName: String?
    private var arKiosk: ARKioskModel!
    var paymentType : PaymentType?
    
    weak var arKioskDelegate: ARKioskDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true

        setARKiosk()
        addGestureRecognizer()

        makeCornerRoundShape(targetView: self.buttonView, cornerRadius: 10)
        makeCornerRoundShape(targetView: descriptionView, cornerRadius: 20)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Explore Ticket", bundle: Bundle.main){
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
        }
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        
    }
}

extension ARKioskViewController {

    @IBAction func buttonTapped(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.arKioskDelegate?.didARKioskFinish()
        }
    }
    
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        descriptionView.isHidden = true
    }
    
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }
    
    // MARK: - Feature Methods
    
    func setARKiosk() {
        guard let kiosk = arKioskDelegate?.selectedARKiosk() else {
            return
        }
        self.arKiosk = kiosk
        self.arKiosk.setSceneView(sceneView: sceneView)
    }
    
    func addGestureRecognizer() {
        let gestureRecongnizers = GestureRecongizerCreator.applyToARKiosk(target: arKiosk)
        
        gestureRecongnizers.forEach { sceneView.addGestureRecognizer($0) }
    }

    func animateButton ()
    {
        DispatchQueue.main.async {
            self.buttonView.alpha = 0.0
            self.arExperienceButton.setTitle("탐험 종료", for: .normal)
            UIView.animate(withDuration: 0.8, delay: 0.2, options: .curveEaseIn, animations: {
                self.buttonView.alpha = 1.0
            })
        }

    }
    
    func renderer (_ renderer : SCNSceneRenderer, nodeFor anchor: ARAnchor )-> SCNNode? {
        animateButton()

        if let _ = anchor as? ARImageAnchor {
            return arKiosk.kioskContainerNode
        }
        
        return nil
    }
}

