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

    @IBOutlet weak var PartyStarterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if(FBSDKAccessToken.currentAccessToken() != nil) {
            
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
        } else {
            var temp_label = UILabel(frame: CGRectMake(0, 0, 300, 21))
            temp_label.center = CGPointMake(160, (CGFloat)(60 + 30))
            temp_label.textAlignment = NSTextAlignment.Center
            temp_label.text = "Log in to Facebook to invite friends!"
            self.view.addSubview(temp_label)
        }
        
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(NSMutableURLRequest(URL: NSURL(string: "http://localhost:3001/items/5702f996490930636e221f6f")!)) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    
                    if let name = json["title"] as? String {
                        NSLog(name)
                        var label = UILabel(frame: CGRectMake(0, 0, 400, 21))
                        label.center = CGPointMake(160, 360)
                        label.textAlignment = NSTextAlignment.Center
                        label.text = name
                        self.view.addSubview(label)
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                    
                }
                
            }
            
        }
        task.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startParty(sender: UIButton) {
   
        self.performSegueWithIdentifier("StartParty", sender: self)    
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
