//
//  TestViewController.swift
//  DailyBond
//
//  Created by André Vitor Terron on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = User.currentUser()?.profileImage()
        imageView.image = image
    }
    
    @IBAction func buttonClick(sender: AnyObject) {
        println("BUTTON CLICKED")
        FBRequests.sharedInstance.getFriends()
    }
    
    @IBAction func testBirthday(sender: AnyObject) {
        
        UserPost.allPosts().continueWithSuccessResultBlock { (result) -> AnyObject! in
           
            
            println("test results: \(result)")
//            if let birthdays = result as? [UserPost] {
//                let birthday = birthdays[0]
//                println("Got bidays \(birthday)")
//            }
            
            return nil
        }
    
    
    }
    
    @IBAction func shareOnMessenger(sender: AnyObject) {
//        MessengerSharer.testShare()
        User.publishMessage("publiquei");

    }
}
