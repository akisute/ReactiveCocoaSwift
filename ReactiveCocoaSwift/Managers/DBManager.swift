//
//  DBManager.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/19.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import Foundation

public class DBManager {
    
    public let isTemporaryDatabase: Bool
    public let database: CBLDatabase
    
    public class var sharedManager: DBManager {
        struct Static {
            static let instance: DBManager = DBManager()
        }
        return Static.instance
    }
    
    public init(useTemporaryDatabase: Bool = false) {
        self.isTemporaryDatabase = useTemporaryDatabase
        var databaseName: String
        if self.isTemporaryDatabase {
            databaseName = "temp-\(NSUUID().UUIDString.lowercaseString)"
        } else {
            databaseName = "reactive-cocoa-swift"
        }
        let manager = CBLManager.sharedInstance()
        self.database = manager.databaseNamed(databaseName, error: nil)
    }
    
    deinit {
        if self.isTemporaryDatabase {
            self.database.deleteDatabase(nil)
        }
    }
}