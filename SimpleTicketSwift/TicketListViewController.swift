//
//  ViewController.swift
//  SimpleTicketSwift
//
//  Created by Michael Dautermann on 9/14/14.
//  Copyright (c) 2014 Michael Dautermann. All rights reserved.
//

import UIKit

class TicketListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var ticketTableView: UITableView!
    
    let ticketURLsObject : IHSTicketURLS = IHSTicketURLS()
    
    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Jira Tickets"

        // let's load the ticket URLs which we've stashed in a JSON file hiding in the application bundle
        ticketURLsObject.loadTicketURLs()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        var detailVC = segue.destinationViewController as IHRTicketDetailViewController
        
        if let ticketCell = sender as? IHRTicketCollectionTableViewCell
        {
            detailVC.ticketURL = ticketCell.ticketURL
        }
    }
    
    // these table view data source methods populate the table with 
    // Jira ticket numbers, if the app finds them...
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = ticketURLsObject.ticketURLs.count
        
        println("count of urls is \(count)")
        return(ticketURLsObject.ticketURLs.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var ticketCell : IHRTicketCollectionTableViewCell?
        
        ticketCell = tableView.dequeueReusableCellWithIdentifier("JiraCell") as? IHRTicketCollectionTableViewCell
        
        if(ticketCell == nil)
        {
            ticketCell = IHRTicketCollectionTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "JiraCell")
            
            ticketCell?.parentVC = self
        }
        
        var ticketURLs = ticketURLsObject.ticketURLs as NSArray
        
        let fullURLString = ticketURLs.objectAtIndex(indexPath.row) as String
        
        var fullURL = NSURL(string: fullURLString)
        
        ticketCell!.ticketURL = fullURL
        
        ticketCell!.textLabel!.text = fullURL.lastPathComponent
        
        return ticketCell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

