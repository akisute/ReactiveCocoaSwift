//
//  BaseModel.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/23.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import Foundation

public class BaseModel: MTLModel, MTLJSONSerializing {
    
    private var type: String!
    public var modelType: String {
        return self.type!
    }
    
    private class func typeName() -> String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
    
    // MARK: - Mantle
    
    public required init!(coder: NSCoder!) {
        super.init(coder: coder)
        self.type = self.dynamicType.typeName()
    }
    
    public override init!() {
        super.init()
        self.type = self.dynamicType.typeName()
    }
    
    public override init!(dictionary dictionaryValue: [NSObject : AnyObject]!, error: NSErrorPointer) {
        super.init(dictionary: dictionaryValue, error: error)
        self.type = self.dynamicType.typeName()
    }
    
    public class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [:]
    }
    
    public class func typeJSONTransformer() -> NSValueTransformer {
        return MTLValueTransformer.reversibleTransformerWithBlock({ (fromValue) -> AnyObject! in
            return self.typeName()
        })
    }
    
    // MARK: - Mantle Utility
    
    private class var dateFormatter: NSDateFormatter {
        struct Static {
            static let instance: NSDateFormatter = {
                let dateFormatter = NSDateFormatter()
                dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                return dateFormatter
            }()
        }
        return Static.instance
    }
    
    public class func NSDateTransformer() -> NSValueTransformer {
        return MTLValueTransformer.reversibleTransformerWithForwardBlock({ (jsonValue) -> AnyObject! in
            let string = jsonValue as String
            return self.dateFormatter.dateFromString(string)
            }, reverseBlock: { (objectValue) -> AnyObject! in
                let date = objectValue as NSDate
                return self.dateFormatter.stringFromDate(date)
        })
    }
}
