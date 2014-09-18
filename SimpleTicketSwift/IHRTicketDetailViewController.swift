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
            
            
            NSURLConnection.sendAsynchronousRequest(ticketDataRequest, queue: NSOperationQueue.mainQueue(), completionHandler: { response, data, error in
            
                if error == nil
                {
                    if data != nil
                    {
                        var error : NSError?
                        
                        var jsonDictionary : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.allZeros, error: &error) as NSDictionary
                        
                    }
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
