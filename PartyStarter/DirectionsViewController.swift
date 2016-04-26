//
//  DirectionsViewController.swift
//  PartyStarter
//
//  Created by Tyler Robinson on 4/17/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import UIKit
import MapKit

class DirectionsViewController: UIViewController {
    
    var theRoute : MKRoute?
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(320, 758)
        
        var counter = 45
        if(theRoute != nil){
            for step in theRoute!.steps {
                var direction = UILabel(frame: CGRectMake(0, 0, 325, 21))
                direction.center = CGPointMake(160, CGFloat(counter))
                direction.textAlignment = NSTextAlignment.Center
                direction.text = step.instructions
            
                scrollView.addSubview(direction)
            
                counter += 25
            }
        }
    }

        
}
