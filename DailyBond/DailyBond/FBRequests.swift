//
//  FBRequests.swift
//  DailyBond
//
//  Created by André Vitor Terron on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

import Foundation

@objc class FBRequests {
    
    func doSomething() -> Int {
        return 2
    }
    
    func formatString(name: String) -> String {
        return "Hello! your name is \(name)"
    }
    
}