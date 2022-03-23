//
//  WalletViewController.swift
//  SampTask
//
//  Created by Raj Kumar on 22/03/22.
//

import UIKit
import ImageSlideshow

class WalletViewController: UIViewController {
  
    @IBOutlet weak var imageSlideView: ImageSlideshow!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSlideView.contentScaleMode = .scaleAspectFill
        imageSlideView.setImageInputs([
            ImageSource(image: UIImage(named: "Banner1")!),
            ImageSource(image: UIImage(named: "Banner2")!),
        ])
        imageSlideView.slideshowInterval = 2.0
    }

}
