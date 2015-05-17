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
    
    private func getRequest(graphPath : String, params : Dictionary<String,String>, method : String) -> BFTask {
        var task = BFTaskCompletionSource()
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            
            FBSDKGraphRequest(graphPath: graphPath, parameters: params, HTTPMethod: method).startWithCompletionHandler({
                (connection, result:AnyObject?, error) -> Void in
                
                if error != nil {
                    task.trySetError(error)
                }
                else {
                    if let a = result as? Dictionary<String,AnyObject>{
                        task.trySetResult(a["data"])
                    } else {
                        task.trySetResult(0)
                    }

                }
            })
            
        }
        
        return task.task
    }

    func getFriends() -> BFTask {
        return getRequest("me/friends", params : ["fields" : "id,name,birthday,picture,cover"], method: "GET")
    }

    func getNewsFeed() -> BFTask {
        return getRequest("me/home", params : ["limit":"5"], method: "GET")
    }
    
    func getEvents() -> BFTask {
        return getRequest("me/events", params : ["fields": "place,name,start_time,id,rsvp_status,cover"], method: "GET")
    }
 
    func getLastPostDate() -> BFTask {
        return getRequest("me/feed", params : ["limit":"1","fields":"created_time,message"], method: "GET")
    }

    func getInbox() -> BFTask {
        return getRequest("me/inbox", params : ["limit":"5"], method: "GET")
    }
    
    func postToTimeline(message : String) -> BFTask {
        return  getRequest("me/feed", params : ["message":message], method: "POST")
    }
    
}