//
//  DBManager.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/19.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import Foundation

public class DBManager {
    
    public let database: CBLDatabase
    
    public class var sharedManager: DBManager {
        struct Static {
            static let instance: DBManager = DBManager()
        }
        return Static.instance
    }
    
    init() {
        let manager = CBLManager.sharedInstance()
        self.database = manager.databaseNamed("ReactiveCocoaSwift", error: nil)
    }
}