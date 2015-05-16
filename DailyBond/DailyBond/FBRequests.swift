//
//  FBRequests.swift
//  DailyBond
//
//  Created by André Vitor Terron on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

import Foundation

@objc class FBRequests {
    
    static let sharedInstance = FBRequests()
    
    func doSomething() -> Void {
    
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            FBSDKGraphRequest(graphPath: "me/friends", parameters: ["fields" : "id,name,birthday"]).startWithCompletionHandler({ (connection, data, error) -> Void in
                println(data)
                println(error)
            })
        }
        
    }
    
    func formatString(name: String) -> String {
        return "Hello! your name is \(name)"
    }
    
}