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
    
    
    
    @IBAction func getFacebook(sender: AnyObject) {
        let accountStore:ACAccountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook);
        
        
        // TRY TO GET THE CURRENT ACCOUNT GRANTED TO OUR APP
        let acc = accountStore.accountsWithAccountType(accountType);
        let fbAcc = acc.last
        println("FB ACC = \(fbAcc)")
        // Gets current account
        
        
        // REQUEST ACCESS TO THE APP
        let options = [ ACFacebookAppIdKey : "ioHHzrZSRJSMSTR0WZZETXjyjXfgKOZ3uefsMuG5"]
        accountStore.requestAccessToAccountsWithType(accountType, options: options) { (granted: Bool, error:NSError!) -> Void in
            if(granted) {
                println("Access granted")
            } else if let e = error as NSError? {
                if (e.code == 6) {
                    println("User didn't sign in")
                } else if (e.code == 7) {
                    // Apparently, even if the user clicks in 'granted'
                    // it will fall here
                    println("User denied")
                } else {

                    println("Error: \(e)")

                }
            } else {
                println("Nil error")
            }
        }
    }
    
    
    @IBAction func openSettings(sender: UIButton) {
//        BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
//        let canOpenSettings = (UIApplicationOpenSettingsURLString != nil);
//        if (canOpenSettings) {
        if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
//            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            UIApplication.sharedApplication().openURL(url)
        }
//            [[UIApplication sharedApplication] openURL:url];
//        }
    }
    
    @IBAction func dismiss(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
}
