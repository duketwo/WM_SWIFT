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
    static var clubs = [Club]()
    static var imgCache = Dictionary<String, UIImage>()
    
    
    
    class func getImage(imageUrl : String?,completion: ((image: UIImage) -> Void)) {
        
        
        let cache = Util.imgCache as NSDictionary
        if let image = cache.objectForKey(imageUrl!) as? UIImage {
            
            println("[loaded from cache]: " + imageUrl!)
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(image: image)
                    return
                }
            }
            
        } else {
            
            println("[added to cache]: " + imageUrl!)
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                
                let url = NSURL(string: imageUrl!);
                let data = NSData(contentsOfURL: url!)
                let image = UIImage(data: data!)
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    Util.imgCache[imageUrl!] = image
                    completion(image: image!)
                    return
                }
            }
        }
    }
    
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
                        var image = UIImage(data: data!);
                        var newTeam:Team = Team(name: name, group: group, matchesPlayed: matchesPlayed, imageUrl: imageUrl, foundedYear: foundedYear, homeStadium: homeStadium)
                        
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
                        var newPlayer:Player = Player(firstName: firstName, lastName: lastName, nationality: nationality, age:age, goals: goals, imageUrl: imageUrl, birthCity: birthCity)
                        
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
    
    
    class func getClubArray(sort : Bool, completion: ((array: [Club]) -> Void)) {
        
        if(clubs.count > 0) {
            completion(array: self.clubs)
            return
        }
        
        var url  = NSURL(string: "http://www.c4s.de/api/clubs")!
        //var url  = NSURL(string: "http://worldcup.kimonolabs.com/api/clubs")!
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            var error : NSError? = nil
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as? [ [String : AnyObject ] ] {
                    for dict in json {
                        var name = dict["name"] as! String
                        
                        var country = ""
                        if let nCountry = dict["country"] as? String {
                            country = dict["country"] as! String
                        }
                        var stadiumName = dict["stadiumName"] as! String
                        var stadiumCapacity = dict["stadiumCapacity"] as! Int
                        
                        var foundedYear = 0
                        if let nFoundedYear = dict["foundedYear"] as? Int {
                            foundedYear = dict["foundedYear"] as! Int
                        }
                        
                        var imageUrl = dict["logo"] as! String;
                        
                        var newClub:Club = Club(name: name, country: country, stadiumName: stadiumName, stadiumCapacity: stadiumCapacity, foundedYear: foundedYear, imageUrl: imageUrl)
                        
                        self.clubs.append(newClub)
                    }
                    
                    if(sort) {
                        self.clubs.sort({ $0.name < $1.name })
                    }
                    completion(array: self.clubs)
                    
                    
                }
            })
        })
        task.resume()
        
    }
    
    
    
}
