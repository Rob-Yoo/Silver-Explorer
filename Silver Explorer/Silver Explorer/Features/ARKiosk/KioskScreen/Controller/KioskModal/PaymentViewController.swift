//
//  PaymentViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit
import ARKit
import SceneKit

class PaymentViewController: UIViewController, ARKioskDelegate, AlertDelegate {
    
    @IBOutlet private weak var modalTitleLabel: UILabel!
    @IBOutlet private weak var paymentImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!

    weak var menuSelectionDelegate : MenuSelectionDelegate?
    var paymentType: PaymentType = .none

    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderPerPaymentMethod()
    }
}

extension PaymentViewController {
    
    @IBAction func previousBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.menuSelectionDelegate?.moveToPaymentSelectVC()
        }
    }
    
    @IBAction func arExperienceBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: Path.ARKiosk.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ARKioskViewController.self)) as! ARKioskViewController
        vc.arKioskDelegate = self
        vc.appear(sender: self)
    }
    
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }
    
    func renderPerPaymentMethod() {
        modalTitleLabel.text = PaymentModel.paymentModalTitle[paymentType]!
        descriptionLabel.text = PaymentModel.paymentDescriptionText[paymentType]!
        paymentImageView.image = PaymentModel.paymentDescriptionImages[paymentType]!
    }
    
    // MARK: - Custom Alert Method
    
    private func showCustomAlert() {
        let alertVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: AlertViewController.self)) as! AlertViewController
        alertVC.alertDelegate = self
        alertVC.showAlert(sender: self, text: "결제 진행 중 입니다...")
    }
    
    // MARK: - Delegate Methods
    
    func didARKioskFinish() {
        showCustomAlert()
    }
    
    func didAlertDismiss() {
        self.dismiss(animated: false) {
            self.menuSelectionDelegate?.moveToPaymentFinishVC()
        }
    }
    
    func selectedARKiosk() -> ARKioskModel? {
        switch paymentType {
        case .creditCard:
            guard let containerNode: SCNNode = ARKioskForCreditCard.makeContainerNode() else {
                return nil
            }

            return ARKioskForCreditCard(containerNode: containerNode)
        case .barcode:
            guard let containerNode: SCNNode = ARKioskForBarcode.makeContainerNode() else {
                return nil
            }
    
            return ARKioskForBarcode(containerNode: containerNode)
        default:
            return nil
        }
    }
}
