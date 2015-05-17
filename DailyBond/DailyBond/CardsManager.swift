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
    
    static let BIRTHDAY = 0
    static let EVENTS = 1
    static let POSTS = 2
    static let CHATS = 3
    static let WRITE = 4
    
    var index = 0
    var section = 0
    var sizes = Dictionary<Int, Int>()
    
    init() {
        for i in 0...5 {
            sizes[i] = 0
        }
    }
    
    func progress(section:Int) -> Float {
        if (section < self.section) {
            return 1.0
        } else if (section > self.section) {
            return 0.0
        } else {
            if let size = sizes[section] {
                return Float(self.index + 1) / Float(max(1, size))
            } else {
                return 0.0
            }
        }
    }
    
    func loadNextCard() ->BFTask {
        index++
        if (index >= sizes[section]) {
            index = 0
            section++
//            while (sizes[section] == 0 && section <= CardsManager.WRITE) {
//                section++
//            }
            if (section > CardsManager.WRITE) {
                println("NO MORE CARDS!!!!!")
                return BFTask(result: nil)
            }
        }
        return loadCurrentCard()
    }
    
    func loadCurrentCard() -> BFTask {
        let section = self.section
        return loadSection(section).continueWithSuccessBlock({ (task:BFTask!) -> AnyObject! in
            println("HELLO1")
            if let list = task.result as? Array<AnyObject> {
                println("HELLO2")
                if let ctrl = self.newSectionController(section) {
                    println("HELLO3")
                    if (list.count == 0) {
                        return self.loadNextCard()
                    } else if (self.index < list.count) {
                        println("HELLO4")
                        ctrl.cardData = list[self.index]
                        return ctrl
                    }
                }
            }
            return nil
        })
    }
    
    func newSectionController(section:Int) -> CardViewController? {
        switch (section) {
        case CardsManager.BIRTHDAY:
            return CardBirthdayViewController()
        case CardsManager.EVENTS:
            return CardEventViewController()
        case CardsManager.POSTS:
            return CardShowPostViewController()
        case CardsManager.CHATS:
            return CardKeepInTouchViewController()
        case CardsManager.WRITE:
            return CardNewPostViewController()
        default:
            return nil
        }
    }
    
    func loadSection(section:Int) -> BFTask {
        switch (section) {
        case CardsManager.BIRTHDAY:
            return loadBirthdays()
        case CardsManager.EVENTS:
            return loadEvents()
        case CardsManager.POSTS:
            return loadPosts()
        case CardsManager.CHATS:
            return loadChats()
        case CardsManager.WRITE:
            return loadWrite()
        default:
            return BFTask(result: nil)
        }
    }
    
    func loadCards() -> BFTask {
        return BFTask(forCompletionOfAllTasks: [
                loadBirthdays(),
                loadEvents(),
                loadPosts(),
                loadChats(),
                loadWrite()
            ])
    }
    
    func loadBirthdays() -> BFTask {
        return Birthday.allBirthdays().continueWithSuccessResultBlock({ (result: AnyObject!) -> AnyObject! in
            if let list = result as? Array<AnyObject> {
                self.sizes[CardsManager.BIRTHDAY] = list.count
            }
            return result;
        })
    }
    
    func loadEvents() -> BFTask {
        return Event.allEvents().continueWithSuccessResultBlock({ (result: AnyObject!) -> AnyObject! in
            println("WORLD 1")
            if let list = result as? Array<AnyObject> {
                println("WORLD 2")
                self.sizes[CardsManager.EVENTS] = list.count
            }
            println("WORLD 3")
            return result;
        })
    }
    
    func loadPosts() -> BFTask {
        return UserPost.allPosts().continueWithSuccessResultBlock({ (result:AnyObject!) -> AnyObject! in
            
            if let list = result as? Array<AnyObject> {
                println("POSTS 2")
                self.sizes[CardsManager.POSTS] = list.count
            }
            println("POSTS 3")
            return result;
            
        })
    }
    
    func loadChats() -> BFTask {
        return UserMessage.allMessages().continueWithSuccessResultBlock({ (result:AnyObject!) -> AnyObject! in
            
            if let list = result as? Array<AnyObject> {
                println("POSTS 2")
                self.sizes[CardsManager.CHATS] = list.count
            }
            println("POSTS 3")
            return result;
            
        })
    }
    
    func loadWrite() -> BFTask {
        return FBRequests.sharedInstance.getLastPostDate().continueWithSuccessResultBlock({ (result:AnyObject!) -> AnyObject! in
//            if let list = result as? Dictionary<String,AnyObject> {
//                println("POSTS 2")
//                self.sizes[CardsManager.WRITE] = list.count
//            }
//            println("POSTS 3")
//            return result;
            return BFTask(result: [6]);
        })
    }
}