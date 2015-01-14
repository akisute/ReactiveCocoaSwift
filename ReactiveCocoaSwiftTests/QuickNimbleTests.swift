//
//  QuickNimbleTests.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/14.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import UIKit
import Quick
import Nimble

class QuickNimbleTests: QuickSpec {
    override func spec() {
        var date: NSDate?
        beforeEach {
            date = NSDate()
        }
        afterEach {
            date = nil
        }
        
        it("passes some easiest tests") {
            expect(true).to(beTruthy())
            expect(3).to(equal(3))
            expect("test").to(equal("test"))
            expect(date != nil).to(beTruthy())
            //expect(nil).to(beTruthy()) // DOES NOT WORK
        }
        
        context("when there is an additional date") {
            var date2: NSDate?
            beforeEach {
                date2 = NSDate()
            }
            afterEach {
                date2 = nil
            }
            it("is obvious that date2 is later than date1") {
                expect(date2 != nil).to(beTruthy())
                expect(date!.laterDate(date2!)).to(equal(date2!))
            }
        }
    }
}