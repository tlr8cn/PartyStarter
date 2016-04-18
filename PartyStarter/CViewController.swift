//
//  CViewController.swift
//  PartyStarter
//
//  Created by Tyler Robinson on 4/6/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import UIKit
import Foundation
//import Alamofire
//import swiftMongoDB

class CViewController: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!

    
    let donation_perks = DonationPerks.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        scrollview.contentSize = CGSizeMake(320, 758)
        
        showDonationPerks();
        
        //POST Perks to Web Service
        
        /*let dateData = ["some_date" : nowISO8601]
        
        if NSJSONSerialization.isValidJSONObject(dateData){
            
            let url = NSURL(string: "http://localhost:3001/")
            
            var request = NSMutableURLRequest(URL: url!)
            var data = NSJSONSerialization.dataWithJSONObject(dateData, options: nil, error: nil)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.HTTPMethod = "POST"
            request.HTTPBody = data
            
            let task = session.dataTaskWithRequest(request, completionHandler: nil)
            
            task.resume()
        }*/
        
    }
    
    
    
    
    
    func addPerkToList() {
        
        
        var descript_input = ""
        var value_input = ""
        
        for subview in self.scrollview.subviews {
            if subview.tag > 0 {
                
                if subview.tag == 2 {
                    let text_field = subview as! UITextField
                    descript_input = text_field.text as String!
                    
                } else if subview.tag == 3 {
                    let text_field = subview as! UITextField
                    value_input = text_field.text as String!
                }
                subview.removeFromSuperview()
            }
        }
        
        
    }
    
    func movePerksDown() {
        
        var counter = 230
        for subview in self.scrollview.subviews {
            if subview.tag == 10 {
                subview.center = CGPointMake(275, CGFloat(counter))
                counter += 20
            }
        }
        
        moveSubmitButtonDown()
    }
    
    func moveSubmitButtonDown() {
        
        var base = 260
        for subview in self.scrollview.subviews {
            if subview.tag == 25 {
                subview.center = CGPointMake(275, CGFloat(base + self.donation_perks.donation_descripts.count*60))
            }
        }
    }
    
    @IBAction func addDonationPerk(sender: UIButton) {
        
        movePerksDown()

        
        let descriptTextField = UITextField(frame: CGRectMake(150, 110, 250, 30))
        descriptTextField.placeholder = "Donation Perk Description"
        descriptTextField.borderStyle = UITextBorderStyle.RoundedRect
        descriptTextField.tag = 2
        
        let valueTextField = UITextField(frame: CGRectMake(150, 150, 250, 30))
        valueTextField.placeholder = "Donation Amount for Perk"
        valueTextField.borderStyle = UITextBorderStyle.RoundedRect
        valueTextField.tag = 3
        
        var donation_button = UIButton(frame: CGRectMake(175, 190, 200, 30))
        donation_button.setTitle("Create Perk", forState: UIControlState.Normal)
        donation_button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        donation_button.addTarget(self, action: "addPerkToList", forControlEvents: UIControlEvents.TouchUpInside)
        donation_button.tag = 1
        
        self.scrollview.addSubview(descriptTextField)
        self.scrollview.addSubview(valueTextField)
        self.scrollview.addSubview(donation_button)
    }
    
    func showDonationPerks() {
        
        var counter = 110.0
        
        for var i = 0; i < donation_perks.donation_descripts.count; ++i {
            
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
            
            descr_label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
            descr_label.font = descr_label.font.fontWithSize(18)
            
            value_label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.60)
            value_label.font = value_label.font.fontWithSize(18)
            
            
            separator.textColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
            
            descr_label.tag = 10
            value_label.tag = 10
            separator.tag = 10
            

            scrollview.addSubview(descr_label)
            scrollview.addSubview(value_label)
            scrollview.addSubview(separator)
            
            counter += 55.0
        }
        
        if donation_perks.donation_descripts.count >= 1 {
            showSubmitButton()
        }
        
    }
    
    func showSubmitButton() {
        
        var base = 130
        var submit_button = UIButton(frame: CGRectMake(175, (CGFloat)(base + self.donation_perks.donation_descripts.count*60), 200, 30))
        submit_button.setTitle("Create Party!", forState: UIControlState.Normal)
        submit_button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        submit_button.addTarget(self, action: "createParty", forControlEvents: UIControlEvents.TouchUpInside)
        submit_button.tag = 25
        
        self.scrollview.addSubview(submit_button)
    }
    
    
    func createParty() {
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        //config.HTTPAdditionalHeaders = [""]
        let session = NSURLSession(configuration: config)
        let reqEndpoint: String = "http://localhost:3001/items/"
        guard let reqURL = NSURL(string: reqEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let reqURLRequest = NSMutableURLRequest(URL: reqURL)
        reqURLRequest.HTTPMethod = "POST"
        let newposreq = ["Perk Title": descript_input, "Perk": value_input]
        let jsonReq: NSData
        do{
            jsonReq = try NSJSONSerialization.dataWithJSONObject(newposreq, options: [])
            reqURLRequest.HTTPBody = jsonReq
        } catch {
            print("Error: cannot create JSON")
            return
        }
        donation_perks.addDonationPerk(descript_input, value: value_input)
        showDonationPerks()
        
        let task = session.dataTaskWithRequest(reqURLRequest, completionHandler:{ _, _, _ in })
        task.resume()
        
        
    }
    
    /*
    
    func downloadAndUpdate() {
        request(.GET, "https://rocky-meadow-1164.herokuapp.com/todo") .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                self.jsonArray = JSON as? NSMutableArray
                for item in self.jsonArray! {
                    print(item["name"]!)
                    let string = item["name"]!
                    print("String is \(string!)")
                    
                    self.newArray.append(string! as! String)
                }
                print("New array is \(self.newArray)")
                self.tableView.reloadData()
            }
        }
        
    }
    */
    
    

}
