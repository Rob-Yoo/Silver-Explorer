//
//  StackNavigation.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/27.
//

import UIKit


struct Navigator {

    static func moveBacktoHome(vc: UIViewController) {
        vc.navigationController?.popToRootViewController(animated: true)
    }
    
    static func moveToContentIntroductionVC(homeVC: UIViewController) {
        let storyboard = UIStoryboard(name: Path.ContentIntroduction.rawValue, bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: String(describing: ContentIntroductionViewController.self)) as! ContentIntroductionViewController
        
        nextVC.homeDelegate = homeVC as! HomeViewController
        homeVC.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    static func moveToContentVC(vc: UIViewController, content: Content) {
        var contentVC: UIViewController!
        
        switch content {
        case .UIExplore:
            let storyboard = UIStoryboard(name: Path.UIExplore.rawValue, bundle: nil)
            contentVC = storyboard.instantiateViewController(withIdentifier: String(describing: ARCharacterSelectViewController.self))
        case .ARKiosk:
            let storyboard = UIStoryboard(name: Path.KioskMainBoard.rawValue, bundle: nil)
            contentVC = storyboard.instantiateViewController(withIdentifier: String(describing: KioskMainBoardViewController.self))
        case .AIExplore:
            let storyboard = UIStoryboard(name: Path.Scanner.rawValue, bundle: nil)
            contentVC = storyboard.instantiateViewController(withIdentifier: String(describing: ScannerViewController.self))
        default:
            return
        }
        
        vc.navigationController?.pushViewController(contentVC, animated: true)
    }
    
    static func moveToUIExploreVC(vc: UIViewController) {
        let storyboard = UIStoryboard(name: Path.UIExplore.rawValue, bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: String(describing: UIExploreViewController.self)) as? UIExploreViewController else { return }
        
        nextVC.arCharacterDelegate = vc as! ARCharacterSelectViewController
        vc.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    static func moveToMenuSelection(vc: UIViewController) {
        let storyboard = UIStoryboard(name: Path.KioskMainBoard.rawValue, bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: String(describing: MenuSelectionViewController.self)) as? MenuSelectionViewController else { return }
        vc.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    static func moveToReader(vc: UIViewController) {
        let storyboard = UIStoryboard(name: Path.Reader.rawValue, bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: String(describing: ReaderViewController.self)) as? ReaderViewController else { return }
        
        nextVC.documentDataDelegate = vc as! ScannerViewController
        vc.navigationController?.pushViewController(nextVC, animated: true)
    }
}
