//
//  IHRTicketDetailViewController.swift
//  SimpleTicketSwift
//
//  Created by Michael Dautermann on 9/17/14.
//  Copyright (c) 2014 Michael Dautermann. All rights reserved.
//

import UIKit

class IHRTicketDetailViewController: UIViewController {

    @IBOutlet var detailTextView : UITextView!

    var ticketURL : NSURL?

    override func viewDidLoad() {

        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if ticketURL != nil
        {
            var ticketDataRequest = NSURLRequest(URL: ticketURL!, cachePolicy:NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30.0)
            
            var urlAsString = self.ticketURL?.absoluteString
            
            self.navigationItem.title = ticketURL?.lastPathComponent
            
            NSURLConnection.sendAsynchronousRequest(ticketDataRequest, queue: NSOperationQueue.mainQueue(), completionHandler: { response, data, error in
            
                if error == nil
                {
                    if data != nil
                    {
                        var error : NSError?
                        
                        var ticketDetailDictionary : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.allZeros, error: &error) as NSDictionary
                        
                        if error == nil
                        {
                            var detailText = String()
                            var allKeys = ticketDetailDictionary.allKeys as [String]
                            
                            for eachKey in allKeys
                            {
                                var valueFromDict : AnyObject? = ticketDetailDictionary.objectForKey(eachKey)
                                
                                // ? mark here is the swift equivalent of "RespondsToSelector:"
                                if (valueFromDict?.description != nil)
                                {
                                    // and if we're in here, we have a description...
                                    var description : String = valueFromDict!.description

                                    // ... that we can append to the detail text
                                    detailText += "\(description)"
                                }
                                
                            }
                            
                            self.detailTextView.text = detailText
                            
                        } else {
                            var errorDescription = error?.description
                            
                            println("couldn't parse the json data from \(urlAsString) - \(errorDescription)")
                        }
                    }
                } else {
                    var errorDescription = error?.description

                    println("error making connection to \(urlAsString) - \(errorDescription)")
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
