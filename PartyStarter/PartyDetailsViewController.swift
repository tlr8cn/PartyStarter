//
//  PartyDetailsViewController.swift
//  PartyStarter
//
//  Created by Tyler Robinson on 4/28/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import UIKit




//I'm thinking the key is the dollar value of the perk and the
//value is the perk's description
var partyPerks : NSDictionary?

class PartyDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!

    @IBOutlet weak var shakeLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollview.contentSize = CGSizeMake(320, 758)
        
        self.title = "Party Title Goes Here"
        
        print((theTag))
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(NSMutableURLRequest(URL: NSURL(string: "http://party-780753853.us-east-1.elb.amazonaws.com/items")!)) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    let jsp:NSArray = try! NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! NSArray
                    
                    if(jsp.count > 0) {
                        
                        //  self.jsondict = jsp
                        
                        for var i in 0...jsp.count-1 {
                            if let party = jsp[i] as? NSDictionary {
                                //var keyray:NSArray = Array(name.allKeys)
                                /*
                                 let info: NSDictionary
                                 do{
                                 var jsdata = keyray[0].dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: false)
                                 info = try NSJSONSerialization.JSONObjectWithData(jsdata!, options: []) as! NSDictionary} catch{
                                 return
                                 }
                                 */
                                /*let tex = info["Party Title"]!.stringByReplacingOccurrencesOfString("}", withString: "") as! String
                                 print(tex)*/
                                if theTag! == i {
                                    if party["Party Title"] != nil {
                                        partyTitle  = party["Party Title"] as! String
                                    }
                                
                                    if party["Party Address"] != nil {
                                        partyAddress = party["Party Address"] as! String
                                    }
                                    
                                    if party["Perks"] != nil {
                                        
                                        partyPerks = party["Perks"] as! NSDictionary
                                    }
                                }
                                ///   var counter = 360.0
                                //var label = UILabel(frame: CGRectMake(0, 0, 400, 21))
                                //var label2 = UILabel(frame: CGRectMake(0, 0, 400, 21))
                                //     var label3 = UILabel(frame: CGRectMake(0, 300, 400, 400))
                                //var label4 = UILabel(frame: CGRectMake(0, 0, 400, 21))
                                //var separator = UILabel(frame: CGRectMake(0, 0, 400, 21))
                                
                                //label.center = CGPointMake(160, CGFloat(counter+15))
                                //label.textAlignment = NSTextAlignment.Center
                                
                                //label2.center = CGPointMake(160, CGFloat(counter+30))
                                //label2.textAlignment = NSTextAlignment.Center
                                
                                //  label3.center = CGPointMake(160, CGFloat(counter+150))
                                //  label3.textAlignment = NSTextAlignment.Center
                                // label3.lineBreakMode = .ByWordWrapping
                                // label3.numberOfLines = 6
                                
                                //label4.center = CGPointMake(160, CGFloat(counter+70))
                                //label4.textAlignment = NSTextAlignment.Center
                                
                                //        separator.center = CGPointMake(160, CGFloat(counter+160))
                                //       separator.textAlignment = NSTextAlignment.Center
                                //var title = info["Party Title"]
                                //var addr = info["Party Addr"]
                                //var state = info.indexAtPosition(0)
                                //var zip = info["Party Zip"]
                                //label.text = title as! String
                                //  label2.text = addr as! String
                                //     label3.text = info["Party Title"] as! String
                                //label4.text = zip as! String
                                //     separator.text = "__________________________"
                                //self.view.addSubview(label)
                                //self.view.addSubview(label2)
                                //     self.view.addSubview(label3)
                                //self.view.addSubview(label4)
                                //    self.view.addSubview(separator)
                                //   counter += 100.0
                            }
                            
                        }
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                    
                }
            }
        }
        
        task.resume()
        
        
        if(partyAddress != nil) {
            
             print("HEEY")
            
             var title_label = UILabel(frame: CGRectMake(175, 45, 200, 21))
             title_label.textAlignment = NSTextAlignment.Center
             title_label.text = partyTitle
             self.scrollview.addSubview(title_label)
             
             
             var address_label = UILabel(frame: CGRectMake(175, 70, 250, 21))
             address_label.textAlignment = NSTextAlignment.Center
             address_label.text = partyAddress
             self.scrollview.addSubview(address_label)
            
            /*
            var perks_label = UILabel(frame: CGRectMake(175, 90, 200, 21))
            perks_label.textAlignment = NSTextAlignment.Center
            perks_label.text = "Donate to the party for special perks!"
            self.scrollview.addSubview(perks_label)
            */
            
            var counter_base: CGFloat = 100;
            /*
            for( key, value) in partyPerks! {
                
                var perk_val = UILabel(frame: CGRectMake(175, counter_base, 200, 21))
                perk_val.textAlignment = NSTextAlignment.Center
                perk_val.text = "Donate $" + (key as! String) + ":"
                self.scrollview.addSubview(perk_val)
                
                var perk_desc = UILabel(frame: CGRectMake(175, counter_base + 20, 200, 21))
                perk_desc.textAlignment = NSTextAlignment.Center
                perk_desc.text = value as! String
                self.scrollview.addSubview(perk_desc)
                
                
                var separator = UILabel(frame: CGRectMake(150, 0, self.view.frame.size.width, 21))
                separator.center = CGPointMake(275, counter_base + 40)
                separator.textAlignment = NSTextAlignment.Center
                separator.text = "__________________________"
                self.scrollview.addSubview(separator)
                
                counter_base += 50
            }
            */
            
            var route_button = UIButton(frame: CGRectMake(175, 270, 200, counter_base + 15))
            route_button.setTitle("View Route", forState: UIControlState.Normal)
            route_button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            route_button.addTarget(self, action: "partyRoute:", forControlEvents: UIControlEvents.TouchUpInside)
           // details_button.tag = 1
            self.scrollview.addSubview(route_button)
            
        }
        

        
        
        
        
    }
    
    
    func partyRoute(sender: AnyObject) {
        
        var map_vc: MapViewController = MapViewController(nibName: nil, bundle: nil)
        
        //hardcoded for now, but soon this will hold the actual address of this party
    //    party_address = "110 Maywood Ln, Charlottesville, VA, 22903"
        
   //     partyAddress = party_address
        
        self.performSegueWithIdentifier("ViewRoute", sender: self)

        
        
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            shakeLabel.text = "See You at the Party!"
        }
    }
    
}