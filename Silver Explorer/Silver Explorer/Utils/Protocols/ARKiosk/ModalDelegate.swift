//
//  KioskMenuBoardDelegate.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/03.
//

import Foundation

protocol ModalDelegate: AnyObject {
    // MenuSelectionViewController -> ProductOptionSelectViewController
    func productForSelectingOption() -> Product
    
    // ProductOptionSelectViewController -> MenuSelectionViewController
    func productForCart(product: Product)
    
    // MenuSelectionViewController -> PaymentSelectViewController
    func totalPriceForPayment() -> Int
    
    // PaymentFinishViewController -> MenuSelectionViewController
    func backToMainScreen()
    
    // MembershipViewController -> MenuSelectionViewController
    func didMembershipVCFinish()
    
    func moveToPaymentSelectVC()
    
    func moveToPaymentVC(paymentType : PaymentType)
    
    func moveToPaymentFinishVC()
}
