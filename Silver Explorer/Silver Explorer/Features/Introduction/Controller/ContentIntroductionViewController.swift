//
//  ContentDescriptionViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/09.
//

import UIKit

class ContentIntroductionViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    weak var homeDelegate: HomeDelegate?
    private let model: ContentIntroductionModel = ContentIntroductionModel()
    
    private var content: Content {
        guard let cnt = homeDelegate?.content(), cnt != .none else {
            moveBacktoHome(vc: self)
            return .none
        }
        return cnt
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSettingForContentDescription()
    }
    
    
    @IBAction func moveBackBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func exploreStartBtnPressed(_ sender: UIButton) {
        moveToContentVC(vc: self, content: content)
    }
    
    private func initialSettingForContentDescription() {
        titleLabel.text = model.contentTitle[content]!
        descriptionLabel.text = model.contentDescription[content]!
    }
}
