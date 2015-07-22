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
                    println(t.name)
                }

                self.tableView.reloadData()
               
            }
        }
        
        Util.getPlayerArray(true) { players in
            dispatch_async(dispatch_get_main_queue()) {
                for p in Util.players {
                
                   println(p.firstName! + " " + p.lastName!)
                }
                // go to something on the main thread 
            }
        }
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TeamDetail") as! TeamDetailViewController
        vc.team = Util.teams[indexPath.row] as Team
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        var team: Team = Util.teams[row] as Team
        var label: UILabel = cell.contentView.viewWithTag(1) as! UILabel
        var imageView: UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
        imageView.image = team.image
        imageView.userInteractionEnabled = true
        label.text = team.name
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"));
        imageView.addGestureRecognizer(tap);
        
        return cell
    }
    
    func handleTap(sender: UIGestureRecognizer) {
        var imageView: UIImageView = sender.view as! UIImageView;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ImageView") as! ImageViewController;
        vc.logo = imageView.image;
        self.navigationController?.pushViewController(vc, animated:true);
        
    }
    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 1
//    }
//    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return Util.teams.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
}

