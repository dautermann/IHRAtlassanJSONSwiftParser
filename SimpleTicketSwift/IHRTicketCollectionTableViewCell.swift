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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

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
            
            if(selected)
            {
                parentVC?.performSegueWithIdentifier("seeTicketDetail", sender: self)
            }
        }
    }

}
