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
    
    
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var foundedYear: UILabel!
    @IBOutlet weak var homeStadium: UILabel!
    @IBOutlet weak var group: UILabel!
    @IBOutlet weak var matchesPlayed: UILabel!
    
    @IBOutlet weak var teamLogo: UIImageView!
    
    var thisTeam : Team!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTeamDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showTeamDetails(){
        team.text = thisTeam.name
        foundedYear.text = String(thisTeam.yearFounded!)
        homeStadium.text = thisTeam.homeStadium
        group.text = thisTeam.group
        matchesPlayed.text = String(thisTeam.matchesPlayed!)
    }
}