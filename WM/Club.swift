//
//  Clubs.swift
//  WM
//
//  Created by DB on 23/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//


import UIKit

class Club: NSObject {
    
    var name: String?
    var country: String?
    var stadiumName: String?
    var stadiumCapacity: Int?
    var foundedYear: Int?
    var image:UIImage?
    
    init(name: String?, country: String?, stadiumName: String?, stadiumCapacity: Int?, foundedYear: Int?, image: UIImage?) {
        self.name = name
        self.country = country
        self.stadiumName = stadiumName
        self.stadiumCapacity = stadiumCapacity
        self.foundedYear = foundedYear
        self.image = image
    }
}
