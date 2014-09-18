//
//  IHSTicketURLS.swift
//  SimpleTicketSwift
//
//  Created by Michael Dautermann on 9/14/14.
//  Copyright (c) 2014 Michael Dautermann. All rights reserved.
//

import UIKit

class IHSTicketURLS: NSObject {
   
    var ticketURLs: Array<NSURL>!
    
    func recursivelyHuntForTicketURLs<T>(someObject: T) -> Bool {
    
        var found = false
        
        if let someDictionary = someObject as? NSDictionary {
            
            for eachKey in someDictionary.allKeys as [String] {
                
                if eachKey == "Ticket URLs"
                {
                    ticketURLs = someDictionary.objectForKey(eachKey) as [NSURL]
                    
                    for item in ticketURLs as NSArray
                    {
                        println("ticketURLs is \(item)")
                    }
                    
                    return true
                }
                else
                {
                    let someOtherObject = someDictionary.objectForKey(eachKey) as Any
                    
                    found = recursivelyHuntForTicketURLs(someOtherObject)
                }
                
            }
        }
        else
        {
            if let someArray = someObject as? NSArray
            {
                found = recursivelyHuntForTicketURLs(someArray)
            }
        }
        
        return found
    }
    
    
    func loadTicketURLs() {
        
        let fileURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("ticketurljson")
        
        var error: NSError? = nil
        
        let dataFromFile : NSData? = NSData.dataWithContentsOfURL(fileURL, options: NSDataReadingOptions.DataReadingUncached, error: &error)
        if (dataFromFile != nil)
        {
            let rawDataFromFile = dataFromFile as NSData!
            
            let jsonInfoFromFile = NSJSONSerialization.JSONObjectWithData(rawDataFromFile, options: NSJSONReadingOptions.fromMask(0), error: &error) as NSDictionary?
            
            if let jsonDictFromFile = jsonInfoFromFile as NSDictionary!
            {
                let found = recursivelyHuntForTicketURLs(jsonDictFromFile)
                
                println("found ticketurls: \(found)")
            }
            else
            {
                println("error from JSONObjectWithData is \(error)")
            }
        }
        else
        {
            println("error from NSData contentsOfURL is \(error)")
        }
        
    }
    
}
