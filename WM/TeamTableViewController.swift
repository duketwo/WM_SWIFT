//
//  TeamTableViewController.swift
//  WM
//
//  Created by DB on 21/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController, UISearchResultsUpdating  {
    
    /* Search  --------------------------------------------------------- */
    var searchController = UISearchController(searchResultsController: nil)
    var filteredData = [Team]()
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        filteredData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF.name contains[cd] %@", searchController.searchBar.text)
        filteredData = (Util.teams as NSArray).filteredArrayUsingPredicate(searchPredicate) as! [Team]
        self.tableView.reloadData()
    }
    /*  EndSearch  ----------------------------------------------------- */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Search  --------------------------------------------------------- */
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        /*  EndSearch  ----------------------------------------------------- */
        
        Util.getTeamArray(true) { teams in
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        }
        
        Util.getPlayerArray(true) { players in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
                dispatch_async(dispatch_get_main_queue()) {
                }
            }
        }
        
        Util.getClubArray(true) { players in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
                dispatch_async(dispatch_get_main_queue()) {
                }
            }
        }
        
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        
        var team = Util.teams[row]
        if self.searchController.active {
            team = filteredData[row] as Team
        }
        
        var label: UILabel = cell.contentView.viewWithTag(1) as! UILabel
        var imageView: UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
        imageView.image = team.image
        imageView.userInteractionEnabled = true
        label.text = team.name
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"));
        imageView.addGestureRecognizer(tap);
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TeamDetail") as! TeamDetailViewController
        vc.team = Util.teams[indexPath.row] as Team
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleTap(sender: UIGestureRecognizer) {
        var imageView: UIImageView = sender.view as! UIImageView;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ImageView") as! ImageViewController;
        vc.logo = imageView.image;
        self.navigationController?.pushViewController(vc, animated:true);
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.active {
            return filteredData.count
        }
        
        return Util.teams.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
}

