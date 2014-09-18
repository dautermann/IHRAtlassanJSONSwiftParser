//
//  IHRTicketCollectionTableViewCell.swift
//  SimpleTicketSwift
//
//  Created by Michael Dautermann on 9/16/14.
//  Copyright (c) 2014 Michael Dautermann. All rights reserved.
//

import UIKit

class IHRTicketCollectionTableViewCell: UITableViewCell {

    var ticketURL : NSURL?
    
    var parentVC : TicketListViewController?

    func setTicketURL(urlToSet : NSURL)
    {
        ticketURL = urlToSet
    }
    
    func setParentVC(parentVCToSet : TicketListViewController)
    {
        parentVC = parentVCToSet
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        
        if(self.selected != selected)
        {
            // Configure the view for the selected state
            super.setSelected(selected, animated: animated)
            
            // and if we're selected for the first time, let's do a segue to the detail view
            if(selected)
            {
                parentVC?.performSegueWithIdentifier("seeTicketDetail", sender: self)
                
                // and de-select the cell, too
                super.setSelected(false, animated: false)
            }
        }
    }

}
