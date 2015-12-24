//
//  MeTableViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/23.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit

class MeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        performSegueWithIdentifier("ShowLogin", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "ShowLogin":
                let loginVC = segue.destinationViewController as! LoginViewController
                loginVC.navigationItem.hidesBackButton = true
            default:
                break
            }
        }
    }
}
