//
//  HomeViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/26.
//

import UIKit

class HomeViewController: UIViewController, HomeDelegate {

    private var selectedContent: Content = .none

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func touchGestureExploreBtnPressed(_ sender: UIButton) {
        selectedContent = .TouchGestureExplore
        Navigator.moveToContentIntroductionVC(homeVC: self)
    }

    @IBAction func arKioskBtnPressed(_ sender: UIButton) {
        selectedContent = .ARKiosk
        Navigator.moveToContentIntroductionVC(homeVC: self)
    }

    @IBAction func aiExplore(_ sender: UIButton) {
        selectedContent = .AIExplore
        Navigator.moveToContentIntroductionVC(homeVC: self)
    }

    func content() -> Content {
        return selectedContent
    }
}
