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
                label.center = CGPointMake(160, 90)
                label.textAlignment = NSTextAlignment.Center
                label.text = "Invite your friends to a party!"
                self.view.addSubview(label)
                
                for (var i = 0; i < data.count; i++) {
                
                    var temp_label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                    temp_label.center = CGPointMake(160, (CGFloat)(90 + (i+1)*30))
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
            temp_label.center = CGPointMake(160, (CGFloat)(90 + 30))
            temp_label.textAlignment = NSTextAlignment.Center
            temp_label.text = "Log in to Facebook to invite friends!"
            self.view.addSubview(temp_label)
        }
        
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(NSMutableURLRequest(URL: NSURL(string: "http://localhost:3001/items")!)) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    let jsp:NSArray = try! NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! NSArray
                    
                    if(jsp.count > 0) {
                    for var i in 0...jsp.count-1 {
                    if let name = jsp[i] as? NSDictionary {
                        var keyray:NSArray = Array(name.allKeys)
                        
                        let info: NSDictionary
                        do{
                            var jsdata = keyray[0].dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: false)
                            info = try NSJSONSerialization.JSONObjectWithData(jsdata!, options: []) as! NSDictionary} catch{
                                return
                        }
                        /*let tex = info["Party Title"]!.stringByReplacingOccurrencesOfString("}", withString: "") as! String
                        print(tex)*/
                        print(info["Party Title"] as! String)
                        var counter = 360.0
                        //var label = UILabel(frame: CGRectMake(0, 0, 400, 21))
                        //var label2 = UILabel(frame: CGRectMake(0, 0, 400, 21))
                        var label3 = UILabel(frame: CGRectMake(0, 300, 400, 400))
                        //var label4 = UILabel(frame: CGRectMake(0, 0, 400, 21))
                        var separator = UILabel(frame: CGRectMake(0, 0, 400, 21))
                        
                        //label.center = CGPointMake(160, CGFloat(counter+15))
                        //label.textAlignment = NSTextAlignment.Center
                        
                        //label2.center = CGPointMake(160, CGFloat(counter+30))
                        //label2.textAlignment = NSTextAlignment.Center
                        
                        label3.center = CGPointMake(160, CGFloat(counter+150))
                        label3.textAlignment = NSTextAlignment.Center
                        label3.lineBreakMode = .ByWordWrapping
                        label3.numberOfLines = 6
                        
                        //label4.center = CGPointMake(160, CGFloat(counter+70))
                        //label4.textAlignment = NSTextAlignment.Center
                    
                        separator.center = CGPointMake(160, CGFloat(counter+160))
                        separator.textAlignment = NSTextAlignment.Center
                        //var title = info["Party Title"]
                        //var addr = info["Party Addr"]
                        //var state = info.indexAtPosition(0)
                        //var zip = info["Party Zip"]
                        //label.text = title as! String
                      //  label2.text = addr as! String
                        label3.text = info["Party Title"] as! String
                        //label4.text = zip as! String
                        separator.text = "__________________________"
                        //self.view.addSubview(label)
                        //self.view.addSubview(label2)
                        self.view.addSubview(label3)
                        //self.view.addSubview(label4)
                        self.view.addSubview(separator)
                        counter += 100.0
                    }
                }
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
    
    
    @IBAction func viewParties(sender: AnyObject) {
        self.performSegueWithIdentifier("ViewParties", sender: self)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            print("Shaken")
        }
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
