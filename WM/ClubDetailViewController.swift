//
//  ClubDetailViewController.swift
//  WM
//
//  Created by DB on 23/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import Foundation
import UIKit

class ClubDetailViewController: UIViewController {
    
    // init(name: String?, country: String?, stadiumName: String?, stadiumCapacity: Int?, foundedYear: Int?, image: UIImage?) {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stadiumNameLabel: UILabel!
    @IBOutlet weak var stadiumCapacityLabel: UILabel!
    @IBOutlet weak var foundedYearLabel: UILabel!
    @IBOutlet weak var clubImage: UIImageView!
    
    var club : Club!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.userInteractionEnabled = true
        clubImage.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"));
        tap.numberOfTapsRequired = 1
        clubImage.addGestureRecognizer(tap);
        showClubDetails()
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
    
    func showClubDetails(){
        nameLabel.text = club.name
        countryLabel.text = club.country
        stadiumNameLabel.text = club.stadiumName
        stadiumCapacityLabel.text = String(club.stadiumCapacity!)
        foundedYearLabel.text = String(club.foundedYear!)

        Util.getImage(club.imageUrl) { image in
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.clubImage.image = image;
                }
            }
        }

    }
}