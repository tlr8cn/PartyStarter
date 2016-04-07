//
//  DonationPerks.swift
//  PartyStarter
//
//  Created by Tyler Robinson on 4/6/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import Foundation

class DonationPerks {
    
    public var donation_descripts = [String]()
    
    public var donation_values = [String]()
    
    public func addDonationPerk(descript : String, value : String) {
        
        donation_descripts.append(descript)
        donation_values.append(value)
        
    }
    
    
    class var sharedInstance : DonationPerks {
        struct Static {
            
            static let instance : DonationPerks = DonationPerks()
        }
        return Static.instance
    }
}