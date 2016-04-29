//
//  PartyListViewController.swift
//  PartyStarter
//
//  Created by Tyler Robinson on 4/28/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import UIKit
import MapKit


var partyAddress : String?

var partyTitle : String?

var theTag : Int?


class PartyListViewController: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    var counter : CGFloat? = 10.0
    var tag : Int? = 0
    
    var jsondict : NSArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tag! = 0
        
        self.scrollview.contentSize = CGSizeMake(320, 758)
        
        self.title = "Your Friends' Parties"
        
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
                                var party_string : String?
                                if party["Party Title"] != nil {
                                    party_string  = party["Party Title"] as! String
                                }
                                dispatch_async(dispatch_get_main_queue(), {

                                    var details_button = UIButton(frame: CGRectMake(175, self.counter!, 200, 21))
                                    details_button.setTitle(party_string, forState: UIControlState.Normal)
                                    details_button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
                                    details_button.addTarget(self, action: "partyDeets:", forControlEvents: UIControlEvents.TouchUpInside)
                                    details_button.tag = i
                                    self.scrollview.addSubview(details_button)
                                    
                                    
                                })
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
                            self.counter! = self.counter! +  30.0
                            self.tag! += 1
                            
                        }
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                    
                }
            }
        }
        
        task.resume()

    }
    
    

    
    func partyDeets(sender:UIButton) {
        
        theTag = sender.tag
        
        
        //var the_dict = jsondict[indx] as? NSDictionary
        
    //    partyAddress = the_dict!["Party Address"] as! String
        
      //partyTitle = the_dict!["Party Title"] as! String
    
    self.performSegueWithIdentifier("PartyDetails", sender: self)
    }
    
    /*
   
    var tag_counter = 0
    func listPartyInfo(title: String?, starting_y: CGFloat) {
        

        
        
        /*
        var title_label = UILabel(frame: CGRectMake(0, 0, 200, starting_y))
        title_label.textAlignment = NSTextAlignment.Center
        title_label.text = title
        self.scrollview.addSubview(title_label)
        
        
        var address_label = UILabel(frame: CGRectMake(0, 0, 200, starting_y + 30))
        address_label.textAlignment = NSTextAlignment.Center
        address_label.text = address
        self.scrollview.addSubview(address_label)
        
        var details_button = UIButton(frame: CGRectMake(175, 270, 200, starting_y + 60))
        details_button.setTitle("View Details", forState: UIControlState.Normal)
        details_button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        details_button.addTarget(self, action: "partyDetails", forControlEvents: UIControlEvents.TouchUpInside)
        details_button.tag = 1
        self.scrollview.addSubview(details_button)
        */
        /*
        var separator = UILabel(frame: CGRectMake(150, 0, self.view.frame.size.width, 21))
        separator.center = CGPointMake(275, starting_y + 40)
        separator.textAlignment = NSTextAlignment.Center
        separator.text = "__________________________"
        self.view.addSubview(separator)
        */
 
        tag_counter += 1
    
    }
 */
    /*
     let descriptTextField = UITextField(frame: CGRectMake(150, 190, 250, 30))
     descriptTextField.placeholder = "Donation Perk Description"
     descriptTextField.borderStyle = UITextBorderStyle.RoundedRect
     descriptTextField.tag = 2
     
     let valueTextField = UITextField(frame: CGRectMake(150, 240, 250, 30))
     valueTextField.placeholder = "Donation Amount for Perk"
     valueTextField.borderStyle = UITextBorderStyle.RoundedRect
     valueTextField.tag = 3
     
     var donation_button = UIButton(frame: CGRectMake(175, 270, 200, 30))
     donation_button.setTitle("Create Perk", forState: UIControlState.Normal)
     donation_button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
     donation_button.addTarget(self, action: "addPerkToList", forControlEvents: UIControlEvents.TouchUpInside)
     donation_button.tag = 1
     
     self.scrollview.addSubview(descriptTextField)
     self.scrollview.addSubview(valueTextField)
     self.scrollview.addSubview(donation_button)
     
     
     
     
     
     
     
     
     var descr_label = UILabel(frame: CGRectMake(0, 0, 200, 21))
     var value_label = UILabel(frame: CGRectMake(0, 0, 200, 21))
     var separator = UILabel(frame: CGRectMake(150, 0, self.view.frame.size.width, 21))
     
     
     
     
     descr_label.center = CGPointMake(275, CGFloat(counter + 15))
     value_label.center = CGPointMake(275, CGFloat(counter + 35))
     separator.center = CGPointMake(275, CGFloat(counter + 45))
     
     
     descr_label.textAlignment = NSTextAlignment.Center
     value_label.textAlignment = NSTextAlignment.Center
     separator.textAlignment = NSTextAlignment.Center
     
     descr_label.text = donation_perks.donation_descripts[i]
     value_label.text = donation_perks.donation_values[i]
     separator.text = "__________________________"

     descr_label.tag = 10
     value_label.tag = 10
     separator.tag = 10
     
     
     scrollview.addSubview(descr_label)
     scrollview.addSubview(value_label)
     scrollview.addSubview(separator)
     */
    
    

}


