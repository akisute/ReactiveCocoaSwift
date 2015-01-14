//
//  ListViewControllerPresentationTests.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/14.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import UIKit
import Quick
import Nimble
import ReactiveCocoaSwift

class ListViewControllerPresentationTests: QuickSpec {
    override func spec() {
        var presentation: ListViewControllerPresentation!
        
        beforeEach {
            presentation = ListViewControllerPresentation(document: Document())
        }
        
        afterEach {
            presentation = nil
        }
        
        it("should always return document") {
            expect(presentation.document).toNot(beNil())
        }
        
        it("should always return signals") {
            expect(presentation.documentUpdatedSignal).toNot(beNil())
        }
    }
}