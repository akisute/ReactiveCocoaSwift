//
//  DBManagerTests.swift
//  ReactiveCocoaSwift
//
//  Created by Ono Masashi on 2015/01/19.
//  Copyright (c) 2015年 akisute. All rights reserved.
//

import UIKit
import Quick
import Nimble
import ReactiveCocoaSwift

class DBManagerTests: QuickSpec {
    override func spec() {
        var manager: DBManager!
        
        beforeEach {
            manager = DBManager(useTemporaryDatabase: true)
        }
        
        describe("its basic functionarity") {
            context("always") {
                it("should return a blank temporary database") {
                    expect(manager.database).toNot(beNil())
                    expect(manager.database.documentCount).to(equal(0))
                    expect(manager.database.name).to(beginWith("temp"))
                }
            }
        }
        describe("database functionarity") {
            context("always") {
                it("can add new document") {
                    let document = manager.database.createDocument()
                    expect(document).toNot(beNil())
                    document.putProperties(["name": "akisute", "message": "Hello, World!"], error: nil)
                    let document2 = manager.database.documentWithID(document.documentID)
                    expect(document2).toNot(beNil())
                    expect(document2.properties["name"] as String?).to(equal("akisute"))
                    expect(document2.properties["message"] as String?).to(equal("Hello, World!"))
                    expect(document2.properties["no such property"]).to(beNil())
                }
            }
            context("when data is already available") {
                var manager: DBManager!
                beforeEach {
                    manager = DBManager(useTemporaryDatabase: true)
                    let document = manager.database.createDocument()
                    document.putProperties(["name": "akisute", "message": "Hello, World!"], error: nil)
                }
                it("can update existing document") {
                    
                }
                it("can delete existing document") {
                    
                }
            }
        }
    }
}