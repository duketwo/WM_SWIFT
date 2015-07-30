//
//  Team.swift
//  WM
//
//  Created by DB on 21/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import Foundation
import UIKit

class Team: NSObject {
    
    var group: String?
    var matchesPlayed: Int?
    var image:UIImage?
    var name: String?
    var yearFounded: Int?
    var homeStadium: String?
    var imageUrl: String?

    
    init(name: String?, group: String?, matchesPlayed: Int?, image: UIImage?, foundedYear:Int?, homeStadium: String?) {
        
        self.name = name
        self.yearFounded = foundedYear
        self.homeStadium = homeStadium
        self.group = group
        self.matchesPlayed = matchesPlayed
        self.image = image
    }
    
    
    init(name: String?, group: String?, matchesPlayed: Int?, imageUrl: String?, foundedYear:Int?, homeStadium: String?) {
        
        self.name = name
        self.yearFounded = foundedYear
        self.homeStadium = homeStadium
        self.group = group
        self.matchesPlayed = matchesPlayed
        self.imageUrl = imageUrl
    }
    
}