//
//  CViewController.swift
//  PartyStarter
//
//  Created by Tyler Robinson on 4/6/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import UIKit

class CViewController: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!

    
    let donation_perks = DonationPerks.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        scrollview.contentSize = CGSizeMake(320, 758)
        
        showDonationPerks();
        
        
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
        
        donation_perks.addDonationPerk(descript_input, value: value_input)
        showDonationPerks()
        
    }
    
    func movePerksDown() {
        
        var counter = 230
        for subview in self.scrollview.subviews {
            if subview.tag == 10 {
                subview.center = CGPointMake(275, CGFloat(counter))
                counter += 20
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
    }
    
}
