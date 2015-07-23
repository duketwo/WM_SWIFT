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
        showClubDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showClubDetails(){
        nameLabel.text = club.name
        countryLabel.text = club.country
        stadiumNameLabel.text = club.stadiumName
        stadiumCapacityLabel.text = String(club.stadiumCapacity!)
        foundedYearLabel.text = String(club.foundedYear!)
        clubImage.image = club.image
    }
}