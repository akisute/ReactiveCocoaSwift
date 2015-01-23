//
//  BaseModelTests.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/23.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import UIKit
import Quick
import Nimble
import ReactiveCocoaSwift

class BaseModelTests: QuickSpec {
    override func spec() {
        var model: BaseModel!
        
        beforeEach {
            model = BaseModel()
        }
        
        describe("its basic functionarity") {
            context("always") {
                it("returns modelType") {
                    expect(model.modelType).to(equal("BaseModel"))
                }
            }
        }
    }
}
