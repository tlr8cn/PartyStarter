//
//  BViewController.swift
//  PartyStarter
//
//  Created by Tyler Robinson on 4/3/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class BViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var friendsRequest = FBSDKGraphRequest(graphPath:"/me/friends", parameters: nil)
        
        friendsRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            var resultdict = result as! NSDictionary
            //   print("Result Dict: \(resultdict)")
            var data : NSArray = resultdict.objectForKey("data") as! NSArray
            
            var label = UILabel(frame: CGRectMake(0, 0, 400, 21))
            label.center = CGPointMake(160, 60)
            label.textAlignment = NSTextAlignment.Center
            label.text = "Invite your friends to a party!"
            self.view.addSubview(label)
            
            for (var i = 0; i < data.count; i++) {
                
                var temp_label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                temp_label.center = CGPointMake(160, (CGFloat)(60 + (i+1)*30))
                temp_label.textAlignment = NSTextAlignment.Center
                temp_label.text = data[i].valueForKey("name") as! String
                self.view.addSubview(temp_label)
                
              //  let valueDict : NSDictionary = data[i] as! NSDictionary
              //  let id = valueDict.objectForKey("id") as! String
                //print("the id value is \(id)")`
            }
            
            var friends = resultdict.objectForKey("data") as! NSArray
            // print("Found \(friends.count) friends")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
