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
        // Do any additional setup after loading the view, typically from a nib.
        
        ticketURLsObject.loadTicketURLs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return(ticketURLsObject.ticketURLs.count)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var ticketCell : IHRTicketCollectionTableViewCell?
        
        ticketCell = tableView.dequeueReusableCellWithIdentifier("JiraCell") as? IHRTicketCollectionTableViewCell
        
        if(ticketCell == nil)
        {
            ticketCell = IHRTicketCollectionTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "JiraCell")
        }
        
        var ticketURLs = ticketURLsObject.ticketURLs as NSArray
        
        println("getting indexPath row of \(indexPath.row)")
        
        for item in ticketURLs as NSArray
        {
            println("item is \(item)")
            
            if let string = item as? String
            {
                println("item is a string")
            }
            
            if let url = item as? NSURL
            {
                println("item is a url")
            }
            
        }
        
        let fullURLString = ticketURLs.objectAtIndex(indexPath.row) as String
        
        if let fullURL = NSURL.URLWithString(fullURLString)
        {
            ticketCell!.textLabel!.text = fullURL.lastPathComponent
        }
        
        return ticketCell!
    }
}

