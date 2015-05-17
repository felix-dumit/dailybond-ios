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
    
    private func getRequest(graphPath : String, parameters : String) -> Void {
            if (FBSDKAccessToken.currentAccessToken() != nil) {
            FBSDKGraphRequest(graphPath: graphPath, parameters: ["fields" : parameters]).startWithCompletionHandler({ (connection, data, error) -> Void in
                    println(data[1])
                    println(error)

            })
            
        }
    }

    func getFriends() -> BFTask {
        var task = BFTaskCompletionSource()
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            FBSDKGraphRequest(graphPath: "me/friends", parameters: ["fields" : "id,name,birthday"]).startWithCompletionHandler({ (connection, result:AnyObject!, error) -> Void in
                task.setResult(result as! Dictionary<String,AnyObject>)
            })
        }
        return task.task
    }

    func getNewsFeed() -> BFTask {
        var task = BFTaskCompletionSource()
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            FBSDKGraphRequest(graphPath: "me/home", parameters: nil).startWithCompletionHandler({ (connection, result, error) -> Void in
                task.setResult(result as! Dictionary<String,AnyObject>)
            })
        }
        return task.task
    }
    
}