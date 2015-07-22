//
//  ViewController.swift
//  WM
//
//  Created by DB on 21/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        Util.getTeamArray(true) { teams in
            dispatch_async(dispatch_get_main_queue()) {
                for t in teams {
                    println(t.name!)
                }
                
               
            }
        }
        
        
        Util.getPlayerArray(true) { players in
            dispatch_async(dispatch_get_main_queue()) {
                for p in players {
                   println(p.firstName! + " " + p.lastName!)
                }
                // go to something on the main thread 
            }
        }
        
        
        
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
//        let row = indexPath.row
//        var team: Team = teams.objectAtIndex(row) as! Team
//        var label: UILabel = cell.contentView.viewWithTag(1) as! UILabel
//        var imageView: UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
//        imageView.image = team.image
//        imageView.userInteractionEnabled = true
//        label.text = team.name
//        
//        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"));
//        imageView.addGestureRecognizer(tap);
//        
//        return cell
//    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        println("test")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

