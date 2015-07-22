//
//  ImageViewController.swift
//  WM
//
//  Created by DB on 22/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import UIKit
class ImageViewController : UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    
    var logo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.image = logo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
