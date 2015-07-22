//
//  ViewController.swift
//  WM
//
//  Created by DB on 21/07/15.
//  Copyright (c) 2015 Daniel Bader. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        Util.getTeamArray() { teams in
            dispatch_async(dispatch_get_main_queue()) {
                //println("test")
                var olo = teams.sort($0.name < $1.name)
                for t in teams {
                   println(t.name!)
                }
                
                // go to something on the main thread with the image like setting to UIImageView
            }
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

