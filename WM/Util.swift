//
//  Util.swift
//  WM
//
//  Created by DB on 21/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import Foundation
import UIKit

var session = NSURLSession.sharedSession()


class Util  {
    
    class func getTeamArray(completion: ((array: [Team]) -> Void)) {
        
        //var teams : NSMutableArray = [];
        var teams = [Team]()
        var url  = NSURL(string: "http://worldcup.kimonolabs.com/api/teams")!
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            var error : NSError? = nil
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as? [ [String : AnyObject ] ] {
                    for dict in json {
                        var name = dict["name"] as! String
                        var foundedYear = dict["foundedYear"] as! Int
                        var homeStadium = dict["homeStadium"] as! String
                        var group = dict["group"] as! String
                        var matchesPlayed = dict["matchesPlayed"] as! Int
                        var imageUrl = dict["logo"] as! String;
                        
                        let url = NSURL(string: imageUrl);
                        let data = NSData(contentsOfURL: url!)
                        
                        var image = UIImage(data: data!);
                        
                        var newTeam:Team = Team(name: name, group: group, matchesPlayed: matchesPlayed, image: image, foundedYear: foundedYear, homeStadium: homeStadium)
                        
                        teams.append(newTeam);
                        
                        
                        
                    }
                    
                    completion(array: teams)
                    
                }
            })
        })
        task.resume()
        
        //return teams;
        
    }
}
