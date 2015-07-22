//
//  TeamDetailViewController.swift
//  WM
//
//  Created by DB on 22/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import Foundation
import UIKit

class TeamDetailViewController: UIViewController {
    
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var foundedYear: UILabel!
    @IBOutlet weak var homeStadium: UILabel!
    @IBOutlet weak var group: UILabel!
    @IBOutlet weak var matchesPlayed: UILabel!
    
    @IBOutlet weak var teamLogo: UIImageView!
    
    var team : Team!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTeamDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showTeamDetails(){
        teamLabel.text = team.name
        foundedYear.text = String(team.yearFounded!)
        homeStadium.text = team.homeStadium
        group.text = team.group
        matchesPlayed.text = String(team.matchesPlayed!)
        teamLogo.image = team.image
    }
}