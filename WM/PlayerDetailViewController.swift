//
//  PlayerDetailViewController.swift
//  WM
//
//  Created by DB on 22/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import Foundation
import UIKit

// player constructor
// (firstName: String?, lastName: String?, nationality: String?, age:Int?, goals: Int?, image: UIImage?, birthCity: String?)

class PlayerDetailViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var goalsLabel: UILabel!
    @IBOutlet weak var birthCityLabel: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    
    var player : Player!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.userInteractionEnabled = true
        playerImage.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"));
        tap.numberOfTapsRequired = 1
        playerImage.addGestureRecognizer(tap);
        showPlayerDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleTap(sender: UIGestureRecognizer) {
        var imageView: UIImageView = sender.view as! UIImageView;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ImageView") as! ImageViewController;
        vc.logo = imageView.image;
        self.navigationController?.pushViewController(vc, animated:true);
    }
    
    func showPlayerDetails(){
        
        firstNameLabel.text = player.firstName
        lastNameLabel.text = player.lastName
        nationalityLabel.text = player.nationality
        ageLabel.text = String(player.age!)
        goalsLabel.text = String(player.goals!)
        birthCityLabel.text = player.birthCity
        playerImage.image = player.image
    }
}