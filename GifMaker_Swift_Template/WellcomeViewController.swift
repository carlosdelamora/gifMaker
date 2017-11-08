//
//  WellcomeViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Carlos De la mora on 11/5/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class WellcomeViewController: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let proofOfConcept = UIImage.gif(name: "hotlineBling")
        gifImageView.image = proofOfConcept
    }


}
