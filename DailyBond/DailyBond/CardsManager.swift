//
//  CardsManager.swift
//  DailyBond
//
//  Created by André Vitor Terron on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

import Foundation

@objc class CardsManager {
    
    static let sharedInstance = CardsManager();
    
    let BIRTHDAY = 0
    let EVENTS = 1
    let POSTS = 2
    let CHATS = 3
    let WRITE = 4
    
    var index = 0
    var section = 0
    var sizes = Dictionary<Int, Int>()
    
    init() {
        for i in 0...10 {
            sizes[i] = 1
        }
    }
    
    func progress(section:Int, index:Int) -> Float {
        if (section < self.section) {
            return 1.0
        } else if (section > self.section) {
            return 0.0
        } else {
            if let size = sizes[section] {
                return Float(index) / Float(size)
            } else {
                return 0.0
            }
        }
    }
    
    func loadCards() -> BFTask {
        return BFTask(forCompletionOfAllTasks: [
                loadBirthdays()
            ])
    }
    
    func loadBirthdays() -> BFTask {
        return Birthday.allBirthdays().continueWithSuccessResultBlock({ (result: AnyObject!) -> AnyObject! in
            if let list = result as? Array<AnyObject> {
                self.sizes[self.BIRTHDAY] = list.count
            }
            return result;
        })
    }
}