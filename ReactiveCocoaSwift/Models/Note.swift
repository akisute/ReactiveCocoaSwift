//
//  Note.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/14.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import Foundation

public class Note: NSObject {
    public var text: NSString?
    public var createdAt: NSDate = NSDate()
    
    private lazy var timestampDateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en-US")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter
    }()
    public var timestamp: NSString {
        return self.timestampDateFormatter.stringFromDate(self.createdAt)
    }
}
