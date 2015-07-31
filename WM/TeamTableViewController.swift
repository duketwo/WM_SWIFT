//
//  TeamTableViewController.swift
//  WM
//
//  Created by DB on 21/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController, UISearchResultsUpdating  {
    
    var searchController = UISearchController(searchResultsController: nil)
    var filteredData = [Team]()
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredData.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF.name contains[cd] %@", searchController.searchBar.text)
        filteredData = searchController.searchBar.text.isEmpty ? Util.teams :(Util.teams as NSArray).filteredArrayUsingPredicate(searchPredicate) as! [Team]
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        Util.getTeamArray(true) { teams in
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        var team = self.searchController.active ? filteredData[row] : Util.teams[row]
        var label: UILabel = cell.contentView.viewWithTag(1) as! UILabel
        var imageView: UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
        
        
        Util.getImage(team.imageUrl) { image in
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                dispatch_async(dispatch_get_main_queue()) {
                    imageView.image = image;
                }
            }
        }
        
        //        let cache = Util.imgCache as NSDictionary
        //        if let image = cache.objectForKey(team.imageUrl!) as? UIImage {
        //
        //         println("[loaded from cache]: " + team.imageUrl!)
        //
        //            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
        //                dispatch_async(dispatch_get_main_queue()) {
        //                    imageView.image = image;
        //                }
        //            }
        //
        //        } else {
        //            println("[added to cache]: " + team.imageUrl!)
        //
        //            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
        //
        //                let url = NSURL(string: team.imageUrl!);
        //                let data = NSData(contentsOfURL: url!)
        //                let image = UIImage(data: data!)
        //
        //
        //                dispatch_async(dispatch_get_main_queue()) {
        //                    imageView.image = image
        //                    Util.imgCache[team.imageUrl!] = image
        //                }
        //            }
        //
        //        }
        
        imageView.userInteractionEnabled = true
        label.text = team.name
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"));
        imageView.addGestureRecognizer(tap);
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TeamDetail") as! TeamDetailViewController
        vc.team = self.searchController.active ? filteredData[indexPath.row] : Util.teams[indexPath.row]
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
        return self.searchController.active ? filteredData.count : Util.teams.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
}

