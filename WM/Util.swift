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
    
    static var teams = [Team]()
    static var players = [Player]()
    
    class func getTeamArray(sort : Bool, completion: ((array: [Team]) -> Void)) {
        
        if(teams.count > 0) {
            completion(array: self.teams)
            return
        }
        
        var url  = NSURL(string: "http://www.c4s.de/api/teams")!
        //var url  = NSURL(string: "http://worldcup.kimonolabs.com/api/teams")!
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
                        
                        self.teams.append(newTeam);
                        
                    }
                    if(sort) {
                        self.teams.sort({ $0.name < $1.name })
                    }
                    completion(array: self.teams)
                    
                    
                }
            })
        })
        task.resume()
        
    }
    
    class func getPlayerArray(sort : Bool, completion: ((array: [Player]) -> Void)) {
        
        if(players.count > 0) {
            completion(array: self.players)
            return
        }
        var url  = NSURL(string: "http://www.c4s.de/api/players")!
        //var url  = NSURL(string: "http://worldcup.kimonolabs.com/api/players")!
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            var error : NSError? = nil
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as? [ [String : AnyObject ] ] {
                    for dict in json {
                        var firstName = dict["firstName"] as! String
                        var lastName = dict["lastName"] as! String
                        var nationality = dict["nationality"] as! String
                        var age = dict["age"] as! Int
                        var goals = dict["goals"] as! Int
                        var imageUrl = dict["image"] as! String;
                        var birthCity = ""
                        if let bCity = dict["birthCity"]  as? String  {
                            birthCity = dict["birthCity"] as! String;
                        }
                        let url = NSURL(string: imageUrl);
                        let data = NSData(contentsOfURL: url!)
                        var image = UIImage(data: data!);
                        var newPlayer:Player = Player(firstName: firstName, lastName: lastName, nationality: nationality, age:age, goals: goals, image: image, birthCity: birthCity)
                        
                        self.players.append(newPlayer);
                        
                    }
                    if(sort) {
                        self.players.sort({ $0.lastName < $1.lastName })
                    }
                    completion(array: self.players)
                    
                    
                }
            })
        })
        task.resume()
        
    }
    
    
    
}
