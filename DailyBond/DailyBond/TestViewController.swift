//
//  TestViewController.swift
//  DailyBond
//
//  Created by André Vitor Terron on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBAction func buttonClick(sender: AnyObject) {
        println("BUTTON CLICKED")
        FBRequests.sharedInstance.doSomething()
    }
    
    @IBAction func testBirthday(sender: AnyObject) {
        
        var birthdays:[Birthday] = Birthday.generateMockBirthDays() as! [Birthday]
        
        println("Birthdays: \(birthdays)")
    }
    
    @IBAction func shareOnMessenger(sender: AnyObject) {
        MessengerSharer.testShare()
    }
}
