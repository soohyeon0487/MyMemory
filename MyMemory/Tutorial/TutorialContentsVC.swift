//
//  TutorialContentsVC.swift
//  MyMemory
//
//  Created by Soohyeon Lee on 2021/01/14.
//

import UIKit

class TutorialContentsVC: UIViewController {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bgImageView.contentMode = .scaleAspectFill
        
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        
        self.bgImageView.image = UIImage(named: self.imageFile)
    }
    
}
