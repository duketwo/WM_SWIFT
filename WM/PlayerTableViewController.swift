//
//  PlayerTableViewController.swift
//  WM
//
//  Created by DB on 22/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import UIKit

class PlayerTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Util.getPlayerArray(true) { players in
            dispatch_async(dispatch_get_main_queue()) {
                for p in Util.players {
                    
                    println(p.firstName! + " " + p.lastName!)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("PlayerDetail") as! PlayerDetailViewController
        vc.player = Util.players[indexPath.row] as Player
        self.navigationController?.pushViewController(vc, animated: true)
        //self.navigationItem.leftBarButtonItems?.removeAll()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        var player: Player = Util.players[row] as Player
        var label: UILabel = cell.contentView.viewWithTag(1) as! UILabel
        var imageView: UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
        imageView.image = player.image
        imageView.userInteractionEnabled = true
        label.text = player.lastName
        
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
        return Util.players.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
}

