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
                    let document2 = manager.database.existingDocumentWithID(document.documentID)
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
                it("can find existing document using View and Query") {
                    let view = manager.database.viewNamed("name_to_message")
                    view.setMapBlock({ (document, emit) -> Void in
                        emit(document["name"], document["message"])
                    }, version: "1")
                    let query = view.createQuery()
                    let result = query.run(nil)
                    expect(result).toNot(beNil())
                    expect(result!.count).to(equal(1))
                    let row = result.nextRow()
                    expect(row.document).toNot(beNil())
                    expect(row.key as? String).to(equal("akisute"))
                    expect(row.value as? String).to(equal("Hello, World!"))
                }
                context("when document is found") {
                    var document: CBLDocument!
                    beforeEach {
                        let view = manager.database.viewNamed("name_to_message")
                        view.setMapBlock({ (document, emit) -> Void in
                            emit(document["name"], document["message"])
                            }, version: "1")
                        let query = view.createQuery()
                        let result = query.run(nil)
                        document = result.nextRow().document
                    }
                    it("can update existing document") {
                        var properties = document.properties
                        properties["message"] = "Message Updated!"
                        document.putProperties(properties, error: nil)
                        let document2 = manager.database.existingDocumentWithID(document.documentID)
                        expect(document2).toNot(beNil())
                        expect(document2.properties["name"] as String?).to(equal("akisute"))
                        expect(document2.properties["message"] as String?).to(equal("Message Updated!"))
                    }
                    it("can delete existing document") {
                        document.deleteDocument(nil)
                        let document2 = manager.database.existingDocumentWithID(document.documentID)
                        expect(document2).to(beNil())
                    }
                }
            }
        }
    }
}