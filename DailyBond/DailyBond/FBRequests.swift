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
    
    private func getRequest(graphPath : String, params : Dictionary<String,String>) -> BFTask {
        var task = BFTaskCompletionSource()
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            FBSDKGraphRequest(graphPath: graphPath, parameters : params).startWithCompletionHandler({ (connection, result, error) -> Void in
                task.setResult(result as! Dictionary<String,AnyObject>)
            })
        }
        return task.task
    }

    func getFriends() -> BFTask {
        return getRequest("me/friends", params : ["fields" : "id,name,birthday,picture,cover"])
    }

    func getNewsFeed() -> BFTask {
        return getRequest("me/home", params : ["":""])
    }
    
    func getEvents() -> BFTask {
        return getRequest("me/events", params : ["":""])
    }
 
    func getLastPostDate() -> BFTask {
        return getRequest("me/feed", params : ["limit":"1","fields":"created_time,message"])
    }
    
}