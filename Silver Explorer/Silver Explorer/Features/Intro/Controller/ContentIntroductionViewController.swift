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
            Navigator.moveBacktoHome(vc: self)
            return .none
        }
        return cnt
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = model.contentTitle[content]!
        descriptionLabel.text = model.contentDescription[content]!
    }
    
    
    @IBAction func moveBackBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func exploreStartBtnPressed(_ sender: UIButton) {
        Navigator.moveToContentVC(vc: self, content: content)
    }
}
