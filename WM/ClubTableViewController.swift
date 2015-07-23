//
//  ClubTableViewController.swift
//  WM
//
//  Created by DB on 22/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import Foundation
import UIKit


class ClubTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController = UISearchController(searchResultsController: nil)
    var filteredData = [Club]()
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        filteredData.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF.name contains[cd] %@", searchController.searchBar.text)
        filteredData = searchController.searchBar.text.isEmpty ? Util.clubs : (Util.clubs as NSArray).filteredArrayUsingPredicate(searchPredicate) as! [Club]
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        Util.getClubArray(true) { players in
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ClubDetail") as! ClubDetailViewController
        vc.club = self.searchController.active ? filteredData[indexPath.row]: Util.clubs[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        var club = self.searchController.active ? filteredData[row] : Util.clubs[row]
        var label: UILabel = cell.contentView.viewWithTag(1) as! UILabel
        var imageView: UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
        imageView.image = club.image
        imageView.userInteractionEnabled = true
        label.text = club.name
        
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
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchController.active ? filteredData.count : Util.clubs.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
}