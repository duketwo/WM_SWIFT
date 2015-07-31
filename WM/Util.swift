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
        
        var url  = NSURL(string: "http://ipol.io/storage/akse/worldcup/teams.json")!
        //var url  = NSURL(string: "http://www.c4s.de/api/teams")!
        //var url  = NSURL(string: "http://worldcup.kimonolabs.com/api/teams")!
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            var error : NSError? = nil
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as? [ [String : AnyObject ] ] {
                    for dict in json {
                        
                        
                        
                        var name = ""
                        if let szName = dict["name"] as? String {
                            name = szName
                        }
                        
                        
                        var foundedYear = 0
                        if let nFoundedYear = dict["foundedYear"] as? Int {
                            foundedYear = nFoundedYear
                        }
                        
                        
                        var homeStadium = ""
                        if  let szHomeStadium = dict["homeStadium"] as? String {
                            homeStadium = szHomeStadium
                        }
                        
                        var group = ""
                        if let szGroup = dict["group"] as? String {
                            group = szGroup
                        }
                        
                        var matchesPlayed = 0
                        if let nMatchesPlayed = dict["matchesPlayed"] as? Int {
                            matchesPlayed = nMatchesPlayed
                        }
                        
                        var imageUrl = ""
                        if let szImageUrl = dict["logo"] as? String {
                            imageUrl = szImageUrl
                        }
                        
                        
                        
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
        
        var url  = NSURL(string: "http://ipol.io/storage/akse/worldcup/players.json")!
        //var url  = NSURL(string: "http://www.c4s.de/api/players")!
        //var url  = NSURL(string: "http://worldcup.kimonolabs.com/api/players")!
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            var error : NSError? = nil
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as? [ [String : AnyObject ] ] {
                    for dict in json {
                        
                        
                        var firstName = ""
                        if let szFirstName = dict["firstName"] as? String {
                            firstName = szFirstName
                        }
                        
                        var lastName = ""
                        if let szLastName = dict["lastName"] as? String {
                            lastName = szLastName
                        }
                        
                        var nationality = ""
                        if let szNationality = dict["nationality"] as? String {
                            nationality = szNationality
                        }
                        
                        
                        var age = 0
                        if let nAge = dict["age"] as? Int {
                            age = nAge
                        }
                        
                        
                        var goals = 0
                        if let nGoals = dict["goals"] as? Int {
                            goals = nGoals
                        }
                        
                        var imageUrl = ""
                        if let szImageUrl = dict["image"] as? String {
                            imageUrl = szImageUrl
                        }
                        
                        
                        var birthCity = ""
                        if let szBirthCity = dict["birthCity"]  as? String  {
                            birthCity = szBirthCity
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
        
        var url  = NSURL(string: "http://ipol.io/storage/akse/worldcup/clubs.json")!
        //var url  = NSURL(string: "http://www.c4s.de/api/clubs")!
        //var url  = NSURL(string: "http://worldcup.kimonolabs.com/api/clubs")!
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            var error : NSError? = nil
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as? [ [String : AnyObject ] ] {
                    for dict in json {
                        
                        var name = ""
                        if let szName = dict["name"] as? String {
                            name = szName
                        }
                        
                        var country = ""
                        if let szCountry = dict["country"] as? String {
                            country = szCountry
                        }
                        
                        var stadiumName = ""
                        if let szStadiumName = dict["stadiumName"] as? String  {
                            stadiumName = szStadiumName
                        }
                        
                        var stadiumCapacity = 0
                        if let nstadiumCapacity = dict["stadiumCapacity"] as? Int {
                            stadiumCapacity = nstadiumCapacity
                        }
                        
                        var foundedYear = 0
                        if let nFoundedYear = dict["foundedYear"] as? Int {
                            foundedYear = nFoundedYear
                        }
                        
                        var imageUrl = ""
                        if let szImageUrl = dict["logo"] as? String {
                            imageUrl = szImageUrl
                        }
                        
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
